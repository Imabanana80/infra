import QtQuick
import Quickshell.Io

Text {
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

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            memProc.running = true
        }
    }

    text: "M: " + mem
    color: Theme.colGreen
    font { family: Theme.fontFamily; pixelSize: Theme.fontSize; bold: true }
}
