import QtQuick
import "root:/Config"

Rectangle {
    id: root

    property bool checked: false
    property color accent: Theme.blue

    signal toggled(bool value)

    implicitWidth: 34
    implicitHeight: 18
    radius: height / 2
    color: checked ? accent : Theme.surface1

    Behavior on color {
        ColorAnimation { duration: Theme.animShort }
    }

    Rectangle {
        width: 14
        height: 14
        radius: height / 2
        color: root.checked ? Theme.crust : Theme.overlay1
        anchors.verticalCenter: parent.verticalCenter
        x: root.checked ? root.width - width - 2 : 2

        Behavior on x {
            NumberAnimation { duration: Theme.animShort; easing.type: Easing.OutCubic }
        }
        Behavior on color {
            ColorAnimation { duration: Theme.animShort }
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: root.toggled(!root.checked)
    }
}
