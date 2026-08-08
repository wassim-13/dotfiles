pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property real volume: 0   
    property bool muted: false

    function setVolume(v: real) {
        const clamped = Math.max(0, Math.min(100, Math.round(v)));
        root.volume = clamped;
        
        const floatVal = (clamped / 100.0).toFixed(2);
        Quickshell.execDetached(["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", floatVal]);
    }

    function toggleMute() {
        root.muted = !root.muted;
        Quickshell.execDetached(["wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle"]);
    }


    Process {
        id: volProc
        command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]
        
        stdout: SplitParser {
            onRead: data => root._parseOutput(data)
        }
    }


    function _parseOutput(line: string) {
        const str = line.trim();
        if (!str.startsWith("Volume:")) return;

        const parts = str.split(/\s+/);
        if (parts.length >= 2) {
            const parsedVol = parseFloat(parts[1]);
            if (!isNaN(parsedVol)) {
                root.volume = Math.round(parsedVol * 100);
            }
        }
        root.muted = str.includes("[MUTED]");
    }


    Timer {
        interval: 80
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            if (!volProc.running) {
                volProc.running = true;
            }
        }
    }
}
