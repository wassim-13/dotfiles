import QtQuick
import "root:/Config"
import "root:/Services"
import "root:/Widgets"

Chip {
    id: root

    visible: Battery.present

    icon: Battery.status === "Charging" ? Icons.batteryCharging
        : Icons.battery

    accent: Battery.status === "Charging" ? Theme.green
          : Battery.percentage < 15 ? Theme.red
          : Theme.green

    label: Battery.percentage + "%"
}
