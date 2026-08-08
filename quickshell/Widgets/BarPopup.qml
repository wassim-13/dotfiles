import QtQuick
import Quickshell
import Quickshell.Hyprland
import "root:/Config"

PopupWindow {
    id: root

    property Item anchorItem
    property bool open: false
    property int contentWidth: 260

    property int anchorEdges: Edges.Bottom | Edges.Right
    property int anchorGravity: Edges.Bottom | Edges.Left

    default property alias contentData: column.data

    visible: open
    color: "transparent"
    implicitWidth: contentWidth
    implicitHeight: card.implicitHeight

    anchor.item: anchorItem
    anchor.edges: anchorEdges
    anchor.gravity: anchorGravity
    anchor.margins.top: 8

    Rectangle {
        id: card
        anchors.fill: parent
        implicitHeight: column.implicitHeight + Theme.popupPadding * 2

        color: Theme.mantle
        radius: Theme.popupRadius
        border.width: 1
        border.color: Theme.surface0

        Column {
            id: column
            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                margins: Theme.popupPadding
            }
            spacing: 2
        }
    }

    HyprlandFocusGrab {
        active: root.open
        windows: [root]
        onCleared: root.open = false
    }
}
