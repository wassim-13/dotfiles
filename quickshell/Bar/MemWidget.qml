import Quickshell
import "root:/Config"
import "root:/Services"
import "root:/Widgets"

Chip {
    icon: Icons.memory
    accent: SysInfo.memUsage > 0.9 ? Theme.red
          : SysInfo.memUsage > 0.75 ? Theme.peach
          : Theme.mauve
    label: SysInfo.memUsedGb.toFixed(1) + "G"
    
    interactive: true
    onClicked: Quickshell.execDetached(["kitty", "--app-id", "btop", "btop"])
}
