import QtQuick
import QtQuick.Layouts
import "root:/Config"
import "root:/Services"
import "root:/Widgets"

Chip {
    id: root

    icon: Swaync.dnd ? Icons.bellOff 
        : Swaync.count > 0 ? Icons.bellRing 
        : Icons.bell

    accent: Swaync.dnd ? Theme.surface2
          : Swaync.count > 0 ? Theme.lavender 
          : Theme.text
          
    label: Swaync.dnd ? "DND" : Swaync.count.toString()

    interactive: true
    active: popup.open
    onClicked: popup.open = !popup.open

    BarPopup {
        id: popup
        anchorItem: root
        contentWidth: 180

        Column {
            width: parent.width
            spacing: 2 

            MenuItem {
                width: parent.width
                icon: Swaync.dnd ? Icons.bellOff : Icons.bell
                label: "Do Not Disturb"
                accent: Swaync.dnd ? Theme.red : Theme.blue
                onTriggered: Swaync.toggleDnd()
            }

            MenuItem {
                width: parent.width
                icon: Icons.close
                label: "Clear All"
                accent: Theme.overlay0
                opacity: Swaync.count > 0 ? 1.0 : 0.4
                
                onTriggered: {
                    if (Swaync.count > 0) {
                        Swaync.clearAll();
                        popup.open = false;
                    }
                }
            }
            
            Rectangle {
                width: parent.width
                height: 1
                color: Theme.surface0
            }
            
            MenuItem {
                width: parent.width
                icon: Icons.list
                label: "View History"
                accent: Theme.text
                onTriggered: {
                    Swaync.openControlCenter();
                    popup.open = false;
                }
            }
        }
    }
}
