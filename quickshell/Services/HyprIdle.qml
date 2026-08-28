pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property bool i_running: false
    property bool s_running: false

    Process {
        id: idle
        command: ["pgrep", "-x", "hypridle"]
        onExited: (code, status) => {
            root.i_running = (code === 0);
        }
    }
    
    Process {
        id: srec
        command: ["pgrep", "screenrec"]
        onExited: (code, status) => {
            root.s_running = (code === 0);
        }
    }


    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            if (!idle.running) {
                idle.running = true;
            }
            if (!srec.running) {
                srec.running = true;
            }
        }
    }
}
