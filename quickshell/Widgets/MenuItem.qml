import QtQuick
import QtQuick.Layouts
import "root:/Config"

Rectangle {
    id: root

    property string icon: ""
    property string label: ""
    property color accent: Theme.text

    signal triggered()

    implicitHeight: 30
    radius: Theme.chipRadius
    color: mouse.containsMouse ? Theme.surface0 : "transparent"

    Behavior on color {
        ColorAnimation { duration: Theme.animShort }
    }

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        spacing: 10

        Text {
            text: root.icon
            color: root.accent
            font.family: Theme.fontFamily
            font.pixelSize: Theme.iconSize
        }

        Text {
            text: root.label
            color: Theme.text
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize
            Layout.fillWidth: true
        }
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.triggered()
    }
}
