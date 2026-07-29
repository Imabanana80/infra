import Quickshell
import Quickshell.Wayland
import Niri
import QtQuick
import QtQuick.Layouts

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
    property color colYellow: "#f9e2af"
    property color colBlue: "#89b4fa"

    property string fontFamily: "JetBrains Mono Nerd Font"
    property int fontSize: 14

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
                    color: model.isFocused || model.isActive ? colYellow : colSubtext
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
            id: clock
            property string format: "HH:mm:ss dd MMMM yyyy"
            text: Qt.formatDateTime(new Date(), clock.format)
            font.pixelSize: fontSize
            font.family: fontFamily
            color: colBlue

            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: clock.text = Qt.formatDateTime(new Date(), clock.format)
            }
        }
    }

    
}
