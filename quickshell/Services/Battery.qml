pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property int percentage: 0
    property string status: "Unknown"
    property bool present: false

    readonly property int interval: 5000

    FileView {
        id: capFile
        path: "/sys/class/power_supply/BAT0/capacity"
        onLoaded: {
            const val = parseInt(capFile.text().trim(), 10);
            if (!isNaN(val)) {
                root.percentage = val;
                root.present = true;
            } else {
                root.present = false;
            }
        }
    }

    FileView {
        id: statFile
        path: "/sys/class/power_supply/BAT0/status"
        onLoaded: {
            root.status = statFile.text().trim();
        }
    }

    Timer {
        interval: root.interval
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            capFile.reload();
            statFile.reload();
        }
    }
}
