pragma Singleton

import Quickshell

Singleton {
    readonly property string cpu:      String.fromCodePoint(0xf0ee0)
    readonly property string memory:   String.fromCodePoint(0xf035b)
    readonly property string download: String.fromCodePoint(0xf01da)
    readonly property string upload:   String.fromCodePoint(0xf0552)
    readonly property string ethernet: String.fromCodePoint(0xf0200)
    readonly property string lanOff:   String.fromCodePoint(0xf0318)
    readonly property string calendar: String.fromCodePoint(0xf00ed)
    readonly property string power:    String.fromCodePoint(0xf0425)
    readonly property string restart:  String.fromCodePoint(0xf0709)
    readonly property string lock:     String.fromCodePoint(0xf033e)
    readonly property string logout:   String.fromCodePoint(0xf0343)
    readonly property string suspend: String.fromCodePoint(0xf0594)   
    
    readonly property string volumeHigh:   String.fromCodePoint(0xf057e) 
    readonly property string volumeMedium: String.fromCodePoint(0xf0580) 
    readonly property string volumeLow:    String.fromCodePoint(0xf057f) 
    readonly property string volumeMute:   String.fromCodePoint(0xf0581) 

    readonly property string brightnessHigh:   String.fromCodePoint(0xf00e0)
    readonly property string brightnessMedium: String.fromCodePoint(0xf00de)
    readonly property string brightnessLow:    String.fromCodePoint(0xf00dc)

    readonly property string bell:     String.fromCodePoint(0xf009a)
    readonly property string bellRing: String.fromCodePoint(0xf009e)
    readonly property string bellOff:  String.fromCodePoint(0xf009b)
    readonly property string trash:    String.fromCodePoint(0xf01b4) 

    readonly property string chevronLeft:  String.fromCodePoint(0xf0141)
    readonly property string chevronRight: String.fromCodePoint(0xf0142)
    readonly property string refresh:      String.fromCodePoint(0xf0450)
    readonly property string check:        String.fromCodePoint(0xf012c)
    readonly property string close:        String.fromCodePoint(0xf0156)
    readonly property string battery:      String.fromCodePoint(0xf007a)
    readonly property string batteryCharging: String.fromCodePoint(0xf0084)
    readonly property string list:         String.fromCodePoint(0xf0335)

    readonly property string bluetooth:          String.fromCodePoint(0xf00af) 
    readonly property string bluetoothOff:       String.fromCodePoint(0xf00b2) 
    readonly property string bluetoothConnected: String.fromCodePoint(0xf00b1) 

    readonly property string headphones: String.fromCodePoint(0xf02cb) 
    readonly property string speaker:    String.fromCodePoint(0xf04c3) 
    readonly property string cellphone:  String.fromCodePoint(0xf011c) 
    readonly property string mouse:      String.fromCodePoint(0xf037d) 
    readonly property string keyboard:   String.fromCodePoint(0xf030c) 
    readonly property string watch:      String.fromCodePoint(0xf0b30) 
    readonly property string genericDevice: String.fromCodePoint(0xf0a9c)

    readonly property string wifiOff:  String.fromCodePoint(0xf05aa) 
    readonly property var wifiBars: [
        String.fromCodePoint(0xf091f), // strength 1
        String.fromCodePoint(0xf0922), // strength 2
        String.fromCodePoint(0xf0925), // strength 3
        String.fromCodePoint(0xf0928)  // strength 4
    ]

    function wifi(strength: real): string {
        if (strength >= 75) return wifiBars[3];
        if (strength >= 50) return wifiBars[2];
        if (strength >= 25) return wifiBars[1];
        return wifiBars[0];
    }

    function forBluetooth(iconName: string): string {
        const n = iconName || "";
        if (n.includes("headset") || n.includes("headphone")) return headphones;
        if (n.includes("audio")) return speaker;
        if (n.includes("phone")) return cellphone;
        if (n.includes("mouse")) return mouse;
        if (n.includes("keyboard")) return keyboard;
        if (n.includes("watch")) return watch;
        return genericDevice;
    }
}
