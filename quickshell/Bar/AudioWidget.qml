import QtQuick
import QtQuick.Layouts
import "root:/Config"
import "root:/Services"
import "root:/Widgets"

Chip {
    id: root

    icon: Audio.muted ? Icons.volumeMute
        : Audio.volume > 66 ? Icons.volumeHigh
        : Audio.volume > 33 ? Icons.volumeMedium
        : Icons.volumeLow

    accent: Audio.muted ? Theme.red : Theme.blue
    label: Audio.muted ? "" : Math.round(Audio.volume) + "%"

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
                text: Audio.muted ? Icons.volumeMute : Icons.volumeHigh
                color: Audio.muted ? Theme.red : Theme.blue
                font.family: Theme.fontFamily
                font.pixelSize: Theme.iconSize + 2

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Audio.toggleMute()
                }
            }

            Slider {
                id: volSlider
                Layout.fillWidth: true
                from: 0
                to: 100
                accent: Audio.muted ? Theme.overlay0 : Theme.blue

                Component.onCompleted: volSlider.value = Audio.volume

                Connections {
                    target: Audio
                    function onVolumeChanged() {
                        if (!volSlider.pressed) {
                            volSlider.value = Audio.volume;
                        }
                    }
                }

                onMoved: Audio.setVolume(value)
            }
        }
    }
}
