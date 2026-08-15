import QtQuick

Text {
    id: calendar
    property string format: "dd MMMM yyyy"
    text: Qt.formatDateTime(new Date(), calendar.format)
    color: Theme.colMauve
    font { family: Theme.fontFamily; pixelSize: Theme.fontSize; bold: true }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: calendar.text = Qt.formatDateTime(new Date(), calendar.format)
    }
}
