pragma Singleton

import Quickshell

Singleton {
    readonly property string terminal: "kitty"

    function runInTerminal(command: list<string>) {
        Quickshell.execDetached([terminal, "-e"].concat(command));
    }

    function openSystemMonitor() {
        Quickshell.execDetached([terminal, "--class", "sysmon", "-e", "btop"]);
    }
}
