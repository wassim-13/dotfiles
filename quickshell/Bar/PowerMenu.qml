import QtQuick
import Quickshell
import Quickshell.Hyprland
import "root:/Config"
import "root:/Widgets"

Chip {
    id: root

    property bool menuOpen: false

    icon: Icons.power
    accent: Theme.red
    interactive: true
    active: menuOpen
    onClicked: menuOpen = !menuOpen

    readonly property var actions: [
        { icon: Icons.lock,    label: "Lock",      accent: Theme.blue,  exec: ["hyprlock"] },
        { icon: Icons.logout,  label: "Log out",   accent: Theme.mauve, dispatch: "exit" },
        { icon: Icons.suspend,   label: "Suspend",   accent: Theme.teal,  exec: ["systemctl", "suspend"] },
        { icon: Icons.restart, label: "Reboot",    accent: Theme.peach, exec: ["systemctl", "reboot"] },
        { icon: Icons.power,   label: "Shut down", accent: Theme.red,   exec: ["systemctl", "poweroff"] }
    ]

    function run(action: var) {
        root.menuOpen = false;
        if (action.dispatch) Hyprland.dispatch(action.dispatch);
        else Quickshell.execDetached(action.exec);
    }

    PopupWindow {
        id: popup

        visible: root.menuOpen
        color: "transparent"
        implicitWidth: 170
        implicitHeight: card.implicitHeight

        anchor.item: root
        anchor.edges: Edges.Bottom | Edges.Right
        anchor.gravity: Edges.Bottom | Edges.Left
        anchor.margins.top: 8

        Rectangle {
            id: card
            anchors.fill: parent
            implicitHeight: column.implicitHeight + 8

            color: Theme.mantle
            radius: 10
            border.width: 1
            border.color: Theme.surface0

            Column {
                id: column
                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                    margins: 4
                }
                spacing: 1

                Repeater {
                    model: root.actions

                    delegate: MenuItem {
                        required property var modelData

                        width: column.width
                        icon: modelData.icon
                        label: modelData.label
                        accent: modelData.accent
                        onTriggered: root.run(modelData)
                    }
                }
            }
        }
    }

    HyprlandFocusGrab {
        active: root.menuOpen
        windows: [popup]
        onCleared: root.menuOpen = false
    }
}
