import QtQuick
import "root:/Config"
import "root:/Services"
import "root:/Widgets"

Row {
    spacing: 0

    Chip {
        icon: ""
        accent: Theme.green
        label: NetStat.humanize(NetStat.rxSpeed)
    }

    Chip {
        icon: ""
        accent: Theme.peach
        label: NetStat.humanize(NetStat.txSpeed)
    }
}
