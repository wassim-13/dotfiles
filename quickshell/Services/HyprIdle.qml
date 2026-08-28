pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property bool running: false

    Process {
        id: proc
        command: ["pgrep", "-x", "hypridle"]
        onExited: (code, status) => {
            root.running = (code === 0);
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            if (!proc.running) {
                proc.running = true;
            }
        }
    }
}
