import QtQuick

Text {
    id: clock
    property string format: "HH:mm"
    text: Qt.formatDateTime(new Date(), clock.format)
    color: Theme.colBlue
    font { family: Theme.fontFamily; pixelSize: Theme.fontSize; bold: true }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: clock.text = Qt.formatDateTime(new Date(), clock.format)
    }
}
