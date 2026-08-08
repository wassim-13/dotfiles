pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property int count: 0
    property bool dnd: false

    function toggleDnd() {
        Quickshell.execDetached(["swaync-client", "-d"]);
        root.dnd = !root.dnd; 
    }

    function clearAll() {
        Quickshell.execDetached(["swaync-client", "-C"]);
        root.count = 0;
    }
    
    function openControlCenter() {
        Quickshell.execDetached(["swaync-client", "-t"]);
    }

    Process {
        id: proc
        command: ["swaync-client", "-s"]
        
        stdout: SplitParser {
            onRead: data => {
                try {
                    const json = JSON.parse(data);
                    root.count = json.count ?? 0;
                    root.dnd = json.dnd ?? false;
                } catch(e) {
                }
            }
        }
    }

    Timer {
        interval: 500
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
