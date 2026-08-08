import QtQuick
import QtQuick.Layouts
import "root:/Config"
import "root:/Services"
import "root:/Widgets"

Chip {
    id: root

    icon: Brightness.brightness > 66 ? Icons.brightnessHigh
        : Brightness.brightness > 33 ? Icons.brightnessMedium
        : Icons.brightnessLow

    accent: Theme.yellow
    label: Math.round(Brightness.brightness) + "%"

    interactive: true
    
    active: popup.open
    onClicked: popup.open = !popup.open

    BarPopup {
        id: popup
        anchorItem: root
        contentWidth: 220

        RowLayout {
            width: parent.width
            spacing: 12

            Text {
                text: root.icon
                color: root.accent
                font.family: Theme.fontFamily
                font.pixelSize: Theme.iconSize + 2
            }

            Slider {
                id: brightSlider
                Layout.fillWidth: true
                from: 1 
                to: 100
                accent: Theme.yellow

                Component.onCompleted: brightSlider.value = Brightness.brightness

                Connections {
                    target: Brightness
                    function onBrightnessChanged() {
                        if (!brightSlider.pressed) {
                            brightSlider.value = Brightness.brightness;
                        }
                    }
                }

                onMoved: Brightness.setBrightness(value)
            }
        }
    }
}
