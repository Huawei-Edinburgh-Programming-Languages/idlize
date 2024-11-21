package org.koalaui.arkoala;

import java.util.HashMap;

class ResourceInfo {
    Object resource;
    int holdersCount;
    ResourceInfo(Object resource, int holdersCount) {
        this.resource = resource;
        this.holdersCount = holdersCount;
    }
}

public class ResourceHolder {
    private static int nextResourceId = 100;
    private HashMap<Integer, ResourceInfo> resources  = new HashMap<Integer, ResourceInfo>();
    private static ResourceHolder _instance = null;
    static ResourceHolder instance() {
        if (ResourceHolder._instance == null) {
            ResourceHolder._instance = new ResourceHolder();
        }
        return ResourceHolder._instance;
    }

    public void hold(int resourceId) {
        if (this.resources.get(resourceId) == null)
            throw new Error("Resource " + resourceId + " does not exists, can not hold");
        this.resources.get(resourceId).holdersCount++;
    }

    public void release(int resourceId) {
        if (this.resources.get(resourceId) == null)
            throw new Error("Resource " + resourceId + " does not exists, can not release");
        ResourceInfo resource = this.resources.get(resourceId);
        resource.holdersCount--;
        if (resource.holdersCount <= 0)
            this.resources.remove(resourceId);
    }

    public int registerAndHold(Object resource) {
        int resourceId = ResourceHolder.nextResourceId++;
        this.resources.put(resourceId, new ResourceInfo(resource, 1));
        return resourceId;
    }
}
