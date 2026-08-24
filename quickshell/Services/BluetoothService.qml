pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Bluetooth
import "root:/Config" 

Singleton {
    id: root

    readonly property var adapter: Bluetooth.defaultAdapter
    readonly property bool enabled: adapter ? adapter.enabled : false

    readonly property var connectedDevice: {
        for (const d of Bluetooth.devices.values) {
            if (d.connected) return d;
        }
        return null;
    }

    readonly property var pairedDevices: {
        const out = [];
        for (const d of Bluetooth.devices.values) {
            if (d.paired) out.push(d);
        }
        return out;
    }

    readonly property string label: {
        if (!enabled) return "Off";
        return connectedDevice ? connectedDevice.name : "Disconnected";
    }

    readonly property string icon: {
        if (!enabled) return Icons.bluetoothOff;
        if (connectedDevice) return Icons.bluetoothConnected;
        return Icons.bluetooth;
    }


    function togglePower() {
        if (adapter) {
            Quickshell.execDetached(["bluetoothctl", "power", adapter.enabled ? "off" : "on"]);
        }
    }

    function toggleConnection(device) {
        if (!device) return;
        const action = device.connected ? "disconnect" : "connect";
        
        const cmd = `bluetoothctl devices | grep "${device.name}" | head -n1 | awk '{print $2}' | xargs -I {} bluetoothctl ${action} {}`;
        Quickshell.execDetached(["sh", "-c", cmd]);
    }
}
