pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property real cpuUsage: 0      
    property real memUsage: 0     
    property real memUsedGb: 0
    property real memTotalGb: 0

    property real _prevTotal: 0
    property real _prevBusy: 0

    readonly property int interval: 2000

    FileView {
        id: stat
        path: "/proc/stat"
        onLoaded: {
            const line = stat.text().split("\n", 1)[0];
            const f = line.trim().split(/\s+/).slice(1).map(Number);
            if (f.length < 5) return;

            const total = f.reduce((a, b) => a + b, 0);
            const busy = total - f[3] - f[4]; 

            const dTotal = total - root._prevTotal;
            const dBusy = busy - root._prevBusy;
            root._prevTotal = total;
            root._prevBusy = busy;

            if (dTotal > 0) root.cpuUsage = Math.max(0, Math.min(1, dBusy / dTotal));
        }
    }

    FileView {
        id: meminfo
        path: "/proc/meminfo"
        onLoaded: {
            const kb = {};
            for (const line of meminfo.text().split("\n")) {
                const m = /^(\w+):\s+(\d+)/.exec(line);
                if (m) kb[m[1]] = Number(m[2]);
            }
            if (!kb.MemTotal) return;

            const available = kb.MemAvailable !== undefined ? kb.MemAvailable : kb.MemFree;
            const used = kb.MemTotal - available;

            root.memTotalGb = kb.MemTotal / 1048576;
            root.memUsedGb = used / 1048576;
            root.memUsage = used / kb.MemTotal;
        }
    }

    Timer {
        interval: root.interval
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            stat.reload();
            meminfo.reload();
        }
    }
}
