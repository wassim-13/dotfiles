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


        Row {
            anchors {
                left: parent.left
                leftMargin: 10
                verticalCenter: parent.verticalCenter
            }
            spacing: Theme.chipSpacing
            
            IdleWidget {
                id: idle
                anchors.verticalCenter: parent.verticalCenter
            }
            
            Item {
                id: bar
                visible: idle.visible
                anchors.verticalCenter: parent.verticalCenter
                width: 1 + Theme.chipPadding * 2
                height: 12

                Rectangle {
                    anchors.centerIn: parent
                    width: 1
                    height: parent.height
                    color: Theme.surface1
                }
            }
            
            Workspaces {
                id: workspaces
                anchors.verticalCenter: parent.verticalCenter
                monitor: root.monitor
            }
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
