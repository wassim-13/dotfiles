import QtQuick
import QtQuick.Layouts
import "root:/Config"

Rectangle {
    id: root

    property string icon: ""
    property string label: ""
    property color accent: Theme.text
    property color labelColor: Theme.subtext1
    property bool interactive: false
    property bool active: false
    property int maxLabelWidth: 0

    readonly property bool hovered: mouse.containsMouse

    signal clicked()

    implicitWidth: row.implicitWidth + Theme.chipPadding * 2
    implicitHeight: Theme.chipHeight
    radius: Theme.chipRadius

    color: active ? Theme.surface0
         : (interactive && hovered) ? Theme.surface0
         : "transparent"

    Behavior on color {
        ColorAnimation { duration: Theme.animShort }
    }

    RowLayout {
        id: row
        anchors.centerIn: parent
        spacing: 6

        Text {
            text: root.icon
            visible: text !== ""
            color: root.accent
            font.family: Theme.fontFamily
            font.pixelSize: Theme.iconSize
        }

        Text {
            text: root.label
            visible: text !== ""
            color: root.labelColor
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize
            elide: Text.ElideRight
            Layout.maximumWidth: root.maxLabelWidth > 0 ? root.maxLabelWidth : implicitWidth
        }
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: root.interactive
        enabled: root.interactive
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}
