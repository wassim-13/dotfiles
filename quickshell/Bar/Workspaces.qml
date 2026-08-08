import QtQuick
import Quickshell.Hyprland
import "root:/Config"

Row {
    id: root

    required property var monitor

    spacing: 6

    readonly property var workspaces: {
        const out = [];
        for (const ws of Hyprland.workspaces.values) {
            if (ws.id > 0 && ws.monitor === root.monitor) out.push(ws);
        }
        out.sort((a, b) => a.id - b.id);
        return out;
    }
    readonly property int currentWorkspaceId: {
        for (const ws of root.workspaces) {
            if (ws.focused) return ws.id;
        }
        return 1; 
    }
    Text {
        anchors.verticalCenter: parent.verticalCenter
        text: root.currentWorkspaceId
        color: Theme.text
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        font.bold: true
    }
    Repeater {
        model: root.workspaces

        delegate: Item {
            id: item
            required property var modelData

            implicitWidth: pill.width
            implicitHeight: Theme.chipHeight

            Rectangle {
                id: pill
                anchors.centerIn: parent
                height: 8
                radius: height / 2
                width: item.modelData.focused ? 16 : 8

                color: item.modelData.urgent ? Theme.red
                     : item.modelData.focused ? Theme.lavender
                     : mouse.containsMouse ? Theme.overlay1
                     : Theme.surface2

                Behavior on width {
                    NumberAnimation { duration: Theme.animMedium; easing.type: Easing.OutCubic }
                }
                Behavior on color {
                    ColorAnimation { duration: Theme.animShort }
                }
            }

            MouseArea {
                id: mouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: Hyprland.dispatch("workspace " + item.modelData.id)
            }
        }
    }
}
