import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Niri
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Scope {
    PanelWindow {
        id: bar
        Niri {
            id: niri
            Component.onCompleted: connect()

            onConnected: console.log("Connected to niri")
            onErrorOccurred: function(error) {
                console.error("Connection error:", error)
            }
        }
        
        anchors.top: true
        anchors.left: true
        anchors.right: true
        implicitHeight: 28
        color: Theme.colCrust

        RowLayout {
            anchors.fill: parent
            anchors.margins: 4;
            spacing: 8

            Repeater {
                model: niri.workspaces

                Text {
                        text: model.name || model.index
                        color: model.isFocused || model.isActive ? Theme.colRed : Theme.colOverlay
                        font.pixelSize: Theme.fontSize
                        font.bold: model.isFocused || model.isActive
                        font.family: Theme.fontFamily

                    MouseArea {
                        anchors.fill: parent
                        onClicked: niri.focusWorkspaceById(model.id)
                        cursorShape: Qt.PointingHandCursor
                    }

                }
            }

            Gap {}

            Text {
                text: niri.focusedWindow?.title ?? "-"
                color: Theme.colText
                font.pixelSize: 12
                font.family: Theme.fontFamily
                font.bold: true
            }

            Item { Layout.fillWidth: true }
            Processor {}
            Gap {}
            Memory {}
            Gap {}
            Clock {}
            Gap {}
            Cal {}
        }
    }
}
