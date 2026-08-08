import Quickshell
import "root:/Config"
import "root:/Services"
import "root:/Widgets"

Chip {
    icon: Icons.cpu
    accent: SysInfo.cpuUsage > 0.85 ? Theme.red
          : SysInfo.cpuUsage > 0.6 ? Theme.peach
          : Theme.blue
    label: Math.round(SysInfo.cpuUsage * 100) + "%"
    
    interactive: true
    onClicked: Quickshell.execDetached(["kitty", "--app-id", "btop", "btop"])
}
