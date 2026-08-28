import QtQuick
import "root:/Config"
import "root:/Services"

Rectangle {
    id: root

    property var opac : HyprIdle.running? 0.7 : 0.0;


    anchors.verticalCenter: parent.verticalCenter
    width: 8
    height: 8
    radius: 4
    opacity: opac
    color: Theme.red
    
}
