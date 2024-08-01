package org.koalaui.arkoala;

public class Concurrent {
    public static void main(String[] args) {
        var root = ArkCommonMethodPeer.create(ArkUINodeType.Root, null, 0);
        var component1 = ArkButtonPeer.create(ArkUINodeType.Component, null, 0);
        var component2 = ArkButtonPeer.create(ArkUINodeType.Component, null, 0);
        System.out.println("root " + root.peer + " button1=" + component1.peer + " button2=" + component2.peer);
        insertChildAfter(root, component1, null);

    }

    public static void insertChildAfter(PeerNode parent, PeerNode child, PeerNode after) {
        System.out.println("insertChildAfter parent=" + parent.peer + " child=" + child.peer +
            (after == null ? "" : (" after " + after.peer.toString())));
    }
}
