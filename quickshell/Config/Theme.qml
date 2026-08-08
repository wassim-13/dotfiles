pragma Singleton

import QtQuick
import Quickshell

Singleton {
    readonly property color crust:    "#11111b"
    readonly property color mantle:   "#181825"
    readonly property color base:     "#1e1e2e"
    readonly property color surface0: "#313244"
    readonly property color surface1: "#45475a"
    readonly property color surface2: "#585b70"
    readonly property color overlay0: "#6c7086"
    readonly property color overlay1: "#7f849c"
    readonly property color subtext0: "#a6adc8"
    readonly property color subtext1: "#bac2de"
    readonly property color text:     "#cdd6f4"

    readonly property color rosewater: "#f5e0dc"
    readonly property color flamingo:  "#f2cdcd"
    readonly property color pink:      "#f5c2e7"
    readonly property color mauve:     "#cba6f7"
    readonly property color red:       "#f38ba8"
    readonly property color maroon:    "#eba0ac"
    readonly property color peach:     "#fab387"
    readonly property color yellow:    "#f9e2af"
    readonly property color green:     "#a6e3a1"
    readonly property color teal:      "#94e2d5"
    readonly property color sky:       "#89dceb"
    readonly property color sapphire:  "#74c7ec"
    readonly property color blue:      "#89b4fa"
    readonly property color lavender:  "#b4befe"

    readonly property string fontFamily: "JetBrainsMono Nerd Font"
    readonly property int fontSize: 12
    readonly property int iconSize: 14
    readonly property int menuFontSize: 14
    readonly property int menuIconSize: 17

    readonly property int barHeight: 30
    readonly property int barPadding: 8
    readonly property int chipHeight: 22
    readonly property int chipRadius: 6
    readonly property int chipPadding: 8
    readonly property int chipSpacing: 2
    readonly property int groupSpacing: 10

    readonly property int menuItemHeight: 34
    readonly property int popupPadding: 6
    readonly property int popupRadius: 10
    readonly property int popupMaxListHeight: 260

    readonly property int animShort: 120
    readonly property int animMedium: 200
}
