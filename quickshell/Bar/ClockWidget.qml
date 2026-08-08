import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import "root:/Config"
import "root:/Widgets"

Chip {
    id: root

    icon: Icons.calendar
    accent: Theme.lavender
    labelColor: Theme.text
    label: Qt.formatDateTime(clock.date, "ddd dd MMM  ·  HH:mm")

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    interactive: true
    
    active: popup.open
    onClicked: popup.open = !popup.open

    property int viewMonth: clock.date.getMonth()
    property int viewYear: clock.date.getFullYear()
    
    onActiveChanged: {
        if (active) {
            viewMonth = clock.date.getMonth();
            viewYear = clock.date.getFullYear();
        }
    }

    BarPopup {
        id: popup
        anchorItem: root
        contentWidth: 260
        
        anchorEdges: Edges.Bottom | Edges.HCenter
        anchorGravity: Edges.Bottom | Edges.HCenter

        ColumnLayout {
            width: parent.width
            spacing: 8

            RowLayout {
                Layout.fillWidth: true
                
                Text {
                    text: Icons.chevronLeft
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.iconSize
                    color: leftMouse.containsMouse ? Theme.lavender : Theme.text
                    
                    Behavior on color { ColorAnimation { duration: Theme.animShort } }

                    MouseArea {
                        id: leftMouse
                        anchors.fill: parent
                        anchors.margins: -4
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if (root.viewMonth === 0) {
                                root.viewMonth = 11;
                                root.viewYear--;
                            } else {
                                root.viewMonth--;
                            }
                        }
                    }
                }

                Text {
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    color: Theme.text
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSize
                    font.bold: true
                    text: {
                        const d = new Date(root.viewYear, root.viewMonth, 1);
                        return Qt.formatDateTime(d, "MMMM yyyy");
                    }
                }

                Text {
                    text: Icons.chevronRight
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.iconSize
                    color: rightMouse.containsMouse ? Theme.lavender : Theme.text
                    
                    Behavior on color { ColorAnimation { duration: Theme.animShort } }

                    MouseArea {
                        id: rightMouse
                        anchors.fill: parent
                        anchors.margins: -4
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if (root.viewMonth === 11) {
                                root.viewMonth = 0;
                                root.viewYear++;
                            } else {
                                root.viewMonth++;
                            }
                        }
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Theme.surface0
            }

            DayOfWeekRow {
                Layout.fillWidth: true
                locale: Qt.locale()
                delegate: Text {
                    text: model.shortName
                    font.family: Theme.fontFamily
                    font.pixelSize: 11
                    font.bold: true
                    color: Theme.subtext0
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            MonthGrid {
                id: grid
                Layout.fillWidth: true
                month: root.viewMonth
                year: root.viewYear
                locale: Qt.locale()
                spacing: 4

                delegate: Rectangle {
                    implicitWidth: 28
                    implicitHeight: 28
                    radius: Theme.chipRadius

                    readonly property bool isCurrentMonth: model.month === grid.month
                    readonly property bool isToday: model.date.getDate() === clock.date.getDate() &&
                                                    model.date.getMonth() === clock.date.getMonth() &&
                                                    model.date.getFullYear() === clock.date.getFullYear()

                    color: isToday ? Theme.lavender 
                         : (cellMouse.containsMouse && isCurrentMonth ? Theme.surface0 : "transparent")

                    Behavior on color { ColorAnimation { duration: Theme.animShort } }

                    Text {
                        anchors.centerIn: parent
                        text: model.date.getDate()
                        font.family: Theme.fontFamily
                        font.pixelSize: Theme.fontSize
                        font.bold: parent.isToday
                        color: parent.isToday ? Theme.crust : (parent.isCurrentMonth ? Theme.text : Theme.surface1)
                    }

                    MouseArea {
                        id: cellMouse
                        anchors.fill: parent
                        hoverEnabled: true
                    }
                }
            }
        }
    }
}
