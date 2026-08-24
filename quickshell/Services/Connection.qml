pragma Singleton

import Quickshell
import Quickshell.Networking

Singleton {
    id: root

    readonly property var wifiDevice: _findDevice(DeviceType.Wifi)
    readonly property var wiredDevice: _findDevice(DeviceType.Wired)

    readonly property bool wifiEnabled: Networking.wifiEnabled
    readonly property var wifiNetwork: _activeNetwork(wifiDevice)
    readonly property bool wifiConnected: wifiNetwork !== null
    readonly property string ssid: wifiNetwork ? wifiNetwork.name : ""
    readonly property real signalStrength: wifiNetwork ? (wifiNetwork.signalStrength ?? 0) : 0

    readonly property bool wiredConnected: wiredDevice ? wiredDevice.connected : false

    readonly property string kind: wifiConnected ? "wifi" : (wiredConnected ? "wired" : "none")

    readonly property string label: {
        if (kind === "wifi") return ssid;
        if (kind === "wired") return "Wired";
        return wifiEnabled ? "Offline" : "Wifi off";
    }

    function _findDevice(type: int): var {
        let fallback = null;
        for (const d of Networking.devices.values) {
            if (d.type !== type) continue;
            if (d.connected) return d;
            if (!fallback) fallback = d;
        }
        return fallback;
    }

    function _activeNetwork(device: var): var {
        if (!device || !device.networks) return null;
        for (const n of device.networks.values) {
            if (n.connected) return n;
        }
        return null;
    }

    readonly property var availableNetworks: {
        if (!wifiDevice || !wifiDevice.networks) return [];
        const out = [];
        for (const n of wifiDevice.networks.values) {
            out.push(n);
        }
        out.sort((a, b) => (b.signalStrength ?? 0) - (a.signalStrength ?? 0));
        return out;
    }

    function toggleWifi() {
        Quickshell.execDetached(["nmcli", "radio", "wifi", wifiEnabled ? "off" : "on"]);
    }

    function connectNetwork(network) {
        if (!network || !network.name) return;
        Quickshell.execDetached(["nmcli", "device", "wifi", "connect", network.name]);
    }
}
