import QtQuick 2.14
import QtQuick.Controls 1.2

ApplicationWindow {
    id: root

    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Button {
        anchors.centerIn: parent
        text: qsTr("Click me")

        onClicked: {
            var component = Qt.createComponent("Download.qml")
            var window    = component.createObject(root)
            window.show()
        }
    }
}
