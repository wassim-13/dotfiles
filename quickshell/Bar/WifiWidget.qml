import QtQuick
import Quickshell
import "root:/Config"
import "root:/Services"
import "root:/Widgets"

Chip {
    id: root
    icon: Connection.kind === "wifi" ? Icons.wifi(Connection.signalStrength)
        : Connection.kind === "wired" ? Icons.ethernet
        : Connection.wifiEnabled ? Icons.wifi(0)
        : Icons.wifiOff

    accent: Connection.kind === "none" ? Theme.overlay0 : Theme.sky
    label: ""
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
                text: "Wi-Fi"
                color: Theme.text
                font.family: Theme.fontFamily
                font.pixelSize: Theme.fontSize
                font.bold: true
            }

            Toggle {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                checked: Connection.wifiEnabled
                accent: Theme.sky
                onToggled: Connection.toggleWifi()
            }
        }

        Rectangle {
            width: parent.width
            height: 1
            color: Theme.surface0
        }

        Repeater {
            model: Connection.availableNetworks

            delegate: MenuItem {
                required property var modelData

                width: parent.width
                
                icon: Icons.wifi(modelData.signalStrength ?? 0)
                label: modelData.name
                
                accent: modelData.connected ? Theme.sky : Theme.text

                onTriggered: {
                    popup.open = false;
                    Connection.connectNetwork(modelData);
                }
            }
        }

        Text {
            visible: Connection.availableNetworks.length === 0
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            text: Connection.wifiEnabled ? "No networks found" : "Wi-Fi is off"
            color: Theme.overlay0
            font.family: Theme.fontFamily
            font.pixelSize: 11
            topPadding: 8
            bottomPadding: 8
        }
    }
}
