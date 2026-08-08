import Quickshell
import "root:/Config"
import "root:/Services"
import "root:/Widgets"

Chip {
    icon: Connection.kind === "wifi" ? Icons.wifi(Connection.signalStrength)
        : Connection.kind === "wired" ? Icons.ethernet
        : Connection.wifiEnabled ? Icons.lanOff
        : Icons.wifiOff

    accent: Connection.kind === "none" ? Theme.overlay0 : Theme.sky
    label: Connection.label
    maxLabelWidth: 120

    interactive: true
    onClicked: Quickshell.execDetached(["nm-connection-editor"])
}
