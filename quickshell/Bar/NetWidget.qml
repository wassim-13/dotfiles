import QtQuick
import "root:/Config"
import "root:/Services"
import "root:/Widgets"

Row {
    spacing: 0

    Chip {
        icon: Icons.download
        accent: Theme.green
        label: NetStat.humanize(NetStat.rxSpeed)
    }

    Chip {
        icon: Icons.upload
        accent: Theme.peach
        label: NetStat.humanize(NetStat.txSpeed)
    }
}
