import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Niri
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

PanelWindow {
    id: root

    Niri {
        id: niri
        Component.onCompleted: connect()

        onConnected: console.log("Connected to niri")
        onErrorOccurred: function(error) {
            console.error("Connection error:", error)
        }
    }

    property color colCrust: "#11111b"
    property color colBase: "#1e1e2e"
    property color colSubtext: "#a6adc8"
    property color colOverlay: "#585b70"
    property color colText: "#cdd6f4"
    property color colLavender: "#b4befe"
    property color colRed: "#f38ba8"
    property color colPeach: "#fab387"
    property color colYellow: "#f9e2af"
    property color colGreen: "#a6e3a1"
    property color colBlue: "#89b4fa"
    property color colMauve: "#cba6f7"
    property color colFlamingo: "#f2cdcd"

    property string fontFamily: "JetBrains Mono Nerd Font"
    property int fontSize: 14

    property string mem: ""
    Process {
        id: memProc

        command: ["sh", "-c", "free | grep Mem"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                var parts = data.trim().split(/\s+/)
                var totalKb = parseInt(parts[1]) || 0
                if (totalKb >= 1024 * 1024) {
                    totalKb = Math.ceil((totalKb / (1024 * 1024))) + "G"
                } else if (totalKb >= 1024) {
                    totalKb = Math.round(kb / 1024) + "M"
                } else {
                    totalKb = totalKb + "K"
                }
                var usedKb = parseInt(parts[2]) || 0
                if (usedKb >= 1024 * 1024) {
                    usedKb = (usedKb / (1024 * 1024)).toFixed(2) + "G"
                } else if (usedKb >= 1024) {
                    usedKb = Math.round(kb / 1024) + "M"
                } else {
                    usedKb = usedKb + "K"
                }
                mem = usedKb + "/" + totalKb
            }
        }
        Component.onCompleted: running = true
    }


    property int cpu: 0
    property var lastCpuIdle: 0
    property var lastCpuTotal: 0
    Process {
        id: cpuProc
        command: ["sh", "-c", "head -1 /proc/stat"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                var p = data.trim().split(/\s+/)
                var idle = parseInt(p[4]) + parseInt(p[5])
                var total = p.slice(1, 8).reduce((a, b) => a + parseInt(b), 0)
                if (lastCpuTotal > 0) {
                    cpu = Math.round(100 * (1 - (idle - lastCpuIdle) / (total - lastCpuTotal)))
                }
                lastCpuTotal = total
                lastCpuIdle = idle
            }
        }
        Component.onCompleted: running = true
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            memProc.running = true
            cpuProc.running = true
        }
    }
    
    anchors.top: true
    anchors.left: true
    anchors.right: true
    implicitHeight: 28
    color: colCrust

    RowLayout {
        anchors.fill: parent
        anchors.margins: 4;
        spacing: 8

        Repeater {
            model: niri.workspaces

            Text {
                    text: model.name || model.index
                    color: model.isFocused || model.isActive ? colRed : colOverlay
                    font.pixelSize: fontSize
                    font.bold: model.isFocused || model.isActive
                    font.family: fontFamily

                MouseArea {
                    anchors.fill: parent
                    onClicked: niri.focusWorkspaceById(model.id)
                    cursorShape: Qt.PointingHandCursor
                }

            }
        }

        Rectangle { width: 1; height: 14; color: colOverlay}

        Text {
            text: niri.focusedWindow?.title ?? "-"
            color: colText
            font.pixelSize: 12
            font.family: fontFamily
            font.bold: true
        }

        Item { Layout.fillWidth: true }
        
        Text {
            text: "C: " + cpu + "٪"
            color: root.colYellow
            font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
        }

        Rectangle { width: 1; height: 14; color: colOverlay}
        
        Text {
            text: "M: " + mem
            color: root.colGreen
            font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
        }

        Rectangle { width: 1; height: 14; color: colOverlay}

        Text {
            id: clock
            property string format: "HH:mm"
            text: Qt.formatDateTime(new Date(), clock.format)
            color: colBlue
            font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }

            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: clock.text = Qt.formatDateTime(new Date(), clock.format)
            }
        }

        Rectangle { width: 1; height: 14; color: colOverlay}

        Text {
            id: date
            property string format: "dd MMMM yyyy"
            text: Qt.formatDateTime(new Date(), date.format)
            color: colMauve
            font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }

            Timer {
                interval: 10000
                running: true
                repeat: true
                onTriggered: date.text = Qt.formatDateTime(new Date(), date.format)
            }
        }
    }
}
