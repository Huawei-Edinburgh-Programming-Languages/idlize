/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.koalaui.arkoala;

import java.util.concurrent.LinkedBlockingDeque;
import java.util.concurrent.BlockingQueue;
import java.util.ArrayList;
import java.util.function.Supplier;

class Node {
    int kind;
    int id;
    static int currentId = 1;
    ArrayList<Node> children = new ArrayList<Node>(0);
    Node(int kind, int id) {
        this.id = id == 0 ? Node.currentId++ : id;
        this.kind = kind;
    }
    static Node create(int kind) {
        return new Node(kind, 0);
    }
    void insertChildAfter(Node child, Node sibling) {
        if (sibling == null) {
            this.children.add(child);
        } else {
            for (int i = 0; i < children.size(); i++) {
                if (children.get(i) == sibling) {
                    this.children.add(i, child);
                    break;
                }
            }
        }
    }
    void removeChild(Node child) {
        this.children.remove(child);
    }
}

interface WorkerTask {
    WorkerResult run(Worker worker);
}

class WorkerResult {
    static WorkerResult Empty = new WorkerResult(null);

    Object result;
    WorkerResult(Object result) {
        this.result = result;
    }
    Object get() {
        return this.result;
    }
}

class CreateTreeTask implements WorkerTask {
    Supplier<Node> builder;
    CreateTreeTask(Supplier<Node> builder) {
        this.builder = builder;
    }
    public WorkerResult run(Worker worker) {
        return new WorkerResult(this.builder.get());
    }
}

class StopTask implements WorkerTask {
    public WorkerResult run(Worker worker) {
        worker.stop();
        return WorkerResult.Empty;
    }
}

interface ResultConsumer {
    public void provide(WorkerResult result);
}

class Worker implements Runnable {
    final BlockingQueue<WorkerTask> queue = new LinkedBlockingDeque<WorkerTask>();
    volatile boolean stopped = false;
    ResultConsumer consumer;
    Worker(ResultConsumer consumer) {
        this.consumer = consumer;
    }
    public void run() {
          try {
            while (!stopped) {
                consumer.provide(queue.take().run(this));
            }
        } catch (InterruptedException e) {}
    }
    public void stop() {
        this.stopped = true;
    }
    public void add(WorkerTask task) {
        this.queue.add(task);
    }
}

public class Concurrent implements ResultConsumer {
    public static void main(String[] args) {
        new Concurrent(30, 10, 4).start();
    }

    int breadth;
    int depth;
    int numWorkers;
    Worker[] workers;
    final BlockingQueue queue = new LinkedBlockingDeque<WorkerResult>();

    Concurrent(int breadth, int depth, int numWorkers) {
        this.breadth = breadth;
        this.depth = depth;
        this.numWorkers = numWorkers;
        this.workers = new Worker[numWorkers];
        for (int i = 0; i < numWorkers; i++) {
            Worker worker = new Worker(this);
            this.workers[i] = worker;
            new Thread(worker).start();
        }
    }

    void start() {
        for (int i = 0; i < numWorkers; i++) {
            this.workers[i].add(new StopTask());
        }
        for (int i = 0; i < numWorkers; i++) {
            try {
                this.queue.take();
            } catch (InterruptedException e) {}
        }
    }

    public void provide(WorkerResult result) {
        System.out.println("provided to main: " + result);
        this.queue.add(result);
    }
}