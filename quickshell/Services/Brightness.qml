pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property real brightness: 0

    function setBrightness(v: real) {
        const val = Math.max(1, Math.min(100, Math.round(v)));
        root.brightness = val;
        Quickshell.execDetached(["brightnessctl", "set", val + "%"]);
    }

    Process {
        id: brightProc
        command: ["brightnessctl", "-m"]
        
        stdout: SplitParser {
            onRead: data => root._parseOutput(data)
        }
    }

    function _parseOutput(line: string) {
        const parts = line.trim().split(",");
        if (parts.length >= 4) {
            const b = parseFloat(parts[3].replace("%", ""));
            if (!isNaN(b)) {
                root.brightness = b;
            }
        }
    }

    Timer {
        interval: 80
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            if (!brightProc.running) {
                brightProc.running = true;
            }
        }
    }
}
