import QtQuick
import Quickshell
import Quickshell.Hyprland
import "root:/Config"

PanelWindow {
    id: root

    required property var modelData
    screen: modelData

    readonly property var monitor: Hyprland.monitorFor(root.screen)

    color: "transparent"
    implicitHeight: Theme.barHeight
    anchors {
        top: true
        left: true
        right: true
    }

    Rectangle {
        anchors.fill: parent
        color: Theme.base

        Rectangle {
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            height: 1
            color: Theme.surface0
        }

        Workspaces {
            anchors {
                left: parent.left
                leftMargin: Theme.barPadding + 4
                verticalCenter: parent.verticalCenter
            }
            monitor: root.monitor
        }

        ClockWidget {
            anchors.centerIn: parent
        }

        Row {
            anchors {
                right: parent.right
                rightMargin: Theme.barPadding
                verticalCenter: parent.verticalCenter
            }
            spacing: Theme.chipSpacing

            CpuWidget {}
            MemWidget {}

            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                width: 1
                height: 12
                color: Theme.surface1
            }

            BrightnessWidget {}
            AudioWidget {}
            
            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                width: 1
                height: 12
                color: Theme.surface1
            }

            WifiWidget {}
            BluetoothWidget {}
            BatteryWidget {}

            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                width: 1
                height: 12
                color: Theme.surface1
            }

            NotificationWidget {}
            PowerMenu {}
        }
    }
}
