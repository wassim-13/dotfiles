import QtQuick
import QtQuick.Layouts
import "root:/Config"
import "root:/Services"
import "root:/Widgets"

Chip {
    id: root

    icon: BluetoothService.icon
    accent: BluetoothService.enabled ? Theme.blue : Theme.overlay0
    label: BluetoothService.label
    maxLabelWidth: 120

    interactive: true
    active: popup.open
    onClicked: popup.open = !popup.open

    BarPopup {
        id: popup
        anchorItem: root
        contentWidth: 240

        Item {
            width: parent.width
            implicitHeight: 34

            Text {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: "Bluetooth"
                color: Theme.text
                font.family: Theme.fontFamily
                font.pixelSize: Theme.fontSize
                font.bold: true
            }

            Toggle {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                checked: BluetoothService.enabled
                accent: Theme.blue
                onToggled: BluetoothService.togglePower()
            }
        }

        Rectangle {
            width: parent.width
            height: 1
            color: Theme.surface0
        }

        Repeater {
            model: BluetoothService.pairedDevices

            delegate: MenuItem {
                required property var modelData

                width: parent.width
                
                icon: Icons.forBluetooth(modelData.icon)
                label: modelData.name
                
                accent: modelData.connected ? Theme.blue : Theme.text

                onTriggered: {
                    popup.open = false;
                    BluetoothService.toggleConnection(modelData);
                }
            }
        }

        Text {
            visible: BluetoothService.pairedDevices.length === 0
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            text: BluetoothService.enabled ? "No paired devices" : "Bluetooth is off"
            color: Theme.overlay0
            font.family: Theme.fontFamily
            font.pixelSize: 11
            topPadding: 8
            bottomPadding: 8
        }
    }
}
