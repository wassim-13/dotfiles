import QtQuick
import "root:/Config"
import "root:/Services"

Row {
    id: root
    
    anchors.verticalCenter: parent.verticalCenter
    spacing: 6

    Rectangle {
        visible: HyprIdle.s_running
        width: 8
        height: 8
        radius: 4
        color: Theme.red

        SequentialAnimation on opacity {
            running: root.visible
            loops: Animation.Infinite
            NumberAnimation { from: 1.0; to: 0.4; duration: 1200; easing.type: Easing.InOutSine }
            NumberAnimation { from: 0.4; to: 1.0; duration: 1200; easing.type: Easing.InOutSine }
        }
    }
    
    Rectangle {
        width: 8
        height: 8
        radius: 4
        opacity : HyprIdle.i_running? 0.6 : 0.0
        color: Theme.orange
    }
}
