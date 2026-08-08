import QtQuick
import QtQuick.Controls.Basic
import "root:/Config"

Slider {
    id: control

    property color accent: Theme.blue
    property color trackColor: Theme.surface0
    property bool showTooltip: true
    property string valueSuffix: "%"
    property real wheelStep: 5

    implicitWidth: 180
    implicitHeight: 28

    hoverEnabled: true

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.NoButton
        onWheel: (wheel) => {
            const delta = wheel.angleDelta.y > 0 ? control.wheelStep : -control.wheelStep;
            const newValue = Math.max(control.from, Math.min(control.to, control.value + delta));
            if (newValue !== control.value) {
                control.value = newValue;
                control.moved();
            }
        }
    }

    background: Rectangle {
        x: control.leftPadding
        y: control.topPadding + (control.availableHeight - height) / 2
        width: control.availableWidth
        height: 6
        radius: height / 2
        color: control.trackColor

        Rectangle {
            width: control.visualPosition * parent.width
            height: parent.height
            radius: height / 2
            color: control.enabled ? control.accent : Theme.surface2

            Behavior on color {
                ColorAnimation { duration: Theme.animShort }
            }
        }
    }

    handle: Rectangle {
        id: handleItem
        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.topPadding + (control.availableHeight - height) / 2

        implicitWidth: control.pressed ? 18 : (control.hovered ? 16 : 12)
        implicitHeight: implicitWidth
        radius: implicitWidth / 2

        color: control.pressed ? Theme.crust : Theme.text
        border.width: 2
        border.color: control.accent

        Behavior on implicitWidth {
            NumberAnimation { duration: Theme.animShort; easing.type: Easing.OutCubic }
        }
        Behavior on color {
            ColorAnimation { duration: Theme.animShort }
        }
        Behavior on border.color {
            ColorAnimation { duration: Theme.animShort }
        }

        Rectangle {
            id: tooltip
            anchors.bottom: parent.top
            anchors.bottomMargin: 8
            anchors.horizontalCenter: parent.horizontalCenter

            visible: opacity > 0
            opacity: (control.hovered || control.pressed) && control.showTooltip ? 1.0 : 0.0

            implicitWidth: label.implicitWidth + 12
            implicitHeight: label.implicitHeight + 4
            radius: Theme.chipRadius
            color: Theme.mantle
            border.width: 1
            border.color: Theme.surface1

            Behavior on opacity {
                NumberAnimation { duration: Theme.animShort; easing.type: Easing.OutCubic }
            }

            Text {
                id: label
                anchors.centerIn: parent
                text: Math.round(control.value) + control.valueSuffix
                color: Theme.text
                font.family: Theme.fontFamily
                font.pixelSize: 11
                font.bold: true
            }
        }
    }
}
