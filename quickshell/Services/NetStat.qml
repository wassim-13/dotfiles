pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property real rxSpeed: 0
    property real txSpeed: 0

    property real _prevRx: 0
    property real _prevTx: 0
    property bool _primed: false

    readonly property int interval: 2000

    readonly property var ignored: /^(lo|docker\d*|veth|br-|virbr|tun|tap|wg)/

    function humanize(bytesPerSec: real): string {
        const units = ["B", "K", "M", "G"];
        let v = bytesPerSec;
        let i = 0;
        while (v >= 1024 && i < units.length - 1) {
            v /= 1024;
            i++;
        }
        return (v >= 10 || i === 0 ? Math.round(v) : v.toFixed(1)) + units[i];
    }

    FileView {
        id: netdev
        path: "/proc/net/dev"
        onLoaded: {
            let rx = 0;
            let tx = 0;
            for (const line of netdev.text().split("\n")) {
                const idx = line.indexOf(":");
                if (idx < 0) continue;
                const name = line.slice(0, idx).trim();
                if (root.ignored.test(name)) continue;

                const f = line.slice(idx + 1).trim().split(/\s+/).map(Number);
                if (f.length < 9) continue;
                rx += f[0];
                tx += f[8];
            }

            const dt = root.interval / 1000;
            if (root._primed) {
                root.rxSpeed = Math.max(0, (rx - root._prevRx) / dt);
                root.txSpeed = Math.max(0, (tx - root._prevTx) / dt);
            }
            root._prevRx = rx;
            root._prevTx = tx;
            root._primed = true;
        }
    }

    Timer {
        interval: root.interval
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: netdev.reload()
    }
}
