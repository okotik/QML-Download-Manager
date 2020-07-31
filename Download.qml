import QtQuick 2.14
import QtQuick.Controls 2.15
import QtQuick.Window 2.14
import DownloadListModel 0.0

Window
{
    id: root
    width: 874
    height: 578
    flags: Qt.FramelessWindowHint

    function statusColor (status)
    {
        if (status === "Downloading")
        {
            return "#10a9e3"
        }
        if (status === "Done")
        {
            return "#2dd077"
        }
        if (status === "Error")
        {
            return "#ff4967"
        }
        else
        {
            return "#aaaaaa"

        }
    }

    Rectangle
    {
        id: titleBar

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        width: parent.width
        height: 38
        color: "#e6e6e6"
        radius: 0


        MouseArea
        {
            anchors.fill: parent
            //                anchors.margins: Style.mouseMargins

            property var previousPosition

            onPressed: previousPosition = Qt.point(mouseX, mouseY)

            onPositionChanged:
            {
                if (pressedButtons == Qt.LeftButton)
                {
                    var dx = mouseX - previousPosition.x;
                    var dy = mouseY - previousPosition.y;
                    root.x = Qt.point(root.x + dx, root.y + dy).x;
                    root.y = Qt.point(root.x + dx, root.y + dy).y;
                }
            }
        }

        Text
        {
            id: title

            anchors.left: parent.left
            anchors.leftMargin: 15
            //            font.family: robotoLight.name
            //            font.weight: Font.Light
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: 10
            color: "#4e5f68"
            text: qsTr("DOWNLOADS")
        }

        Button
        {
            id: closeDownload
            anchors.right: parent.right
            anchors.rightMargin: 15
            anchors.verticalCenter: parent.verticalCenter
            palette
            {
                button: "transparent"
            }
            width: 20
            height: width
            font.pointSize: 13
            text: "X"
            onClicked: root.close()
        }
    }

    Rectangle
    {
        id: body

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: titleBar.bottom
        anchors.bottom: bottomRow.top
        //            anchors.topMargin: Style.margins - Style.tinyMargins
        //            anchors.leftMargin: Style.margins
        //            anchors.rightMargin: Style.margins
        color: "transparent"
        ScrollView
        {
            anchors.fill: parent
            clip: true
            ScrollBar.vertical.policy: ScrollBar.AlwaysOn
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ListView
            {
                id: downloadsList
                anchors.fill: parent


                clip: true
                interactive: false
                focus: true

                model: DownloadListModel {}
                delegate:
                    Rectangle
                {
                    id: downloadsListItem
                    implicitWidth: parent.width
                    implicitHeight: 88

                    color: "transparent"


                    Text
                    {
                        id: deviceNameLb
                        anchors.leftMargin: 15
                        anchors.topMargin: 15
                        color: "#4e5f68"
                        font.pointSize: 10
                        anchors.top: parent.top
                        anchors.left: parent.left
                        horizontalAlignment: Text.AlignLeft
                        wrapMode: Text.WordWrap
                        text: qsTr("Device Name:")
                    }

                    Text
                    {
                        id: deviceName
                        anchors.leftMargin: 10
                        color: "#4e5f68"
                        font.pointSize: 10
                        anchors.top: deviceNameLb.top
                        anchors.left: deviceNameLb.right
                        horizontalAlignment: Text.AlignLeft
                        wrapMode: Text.WordWrap
                        text: DeviceName
                    }

                    Text
                    {
                        id: channelLb
                        width: deviceNameLb.width
                        color: "#4e5f68"
                        font.pointSize: 10
                        anchors.topMargin: 5
                        anchors.left: deviceNameLb.left
                        anchors.top: deviceNameLb.bottom
                        horizontalAlignment: Text.AlignLeft
                        wrapMode: Text.WordWrap
                        text: qsTr("Channel:")
                    }

                    Text
                    {
                        id: channel
                        anchors.left: deviceName.left
                        anchors.top: channelLb.top
                        anchors.verticalCenter: parent.verticalCenter
                        color: "#4e5f68"
                        font.pointSize: 10
                        width: deviceName.width
                        horizontalAlignment: Text.AlignLeft
                        wrapMode: Text.WordWrap
                        text: Channel
                    }

                    Text
                    {
                        id: dateStartLb
                        anchors.top: deviceNameLb.top
                        anchors.left: deviceName.right
                        anchors.leftMargin: 40
                        color: "#4e5f68"
                        font.pointSize: 10
                        horizontalAlignment: Text.AlignLeft
                        wrapMode: Text.WordWrap
                        text: qsTr("From:")
                    }
                    Text
                    {
                        id: dateStart
                        anchors.top: deviceNameLb.top
                        anchors.left: dateStartLb.right
                        anchors.leftMargin: 10
                        color: "#4e5f68"
                        font.pointSize: 10
                        horizontalAlignment: Text.AlignLeft
                        wrapMode: Text.WordWrap
                        text: DateStart
                    }

                    Text
                    {
                        id: dateStopLb
                        anchors.top: channelLb.top
                        anchors.left: dateStartLb.left
                        width: dateStartLb.width
                        color: "#4e5f68"
                        font.pointSize: 10
                        horizontalAlignment: Text.AlignLeft
                        wrapMode: Text.WordWrap
                        text: qsTr("To:")
                    }
                    Text
                    {
                        id: dateStop
                        anchors.top: channelLb.top
                        anchors.left: dateStart.left
                        width: dateStart.width
                        color: "#4e5f68"
                        font.pointSize: 10
                        horizontalAlignment: Text.AlignLeft
                        wrapMode: Text.WordWrap
                        text: DateStop
                    }

                    Text
                    {
                        id: downloadStatusLb
                        anchors.top: deviceNameLb.top
                        anchors.left: dateStart.right
                        anchors.leftMargin: 40
                        color: "#4e5f68"
                        font.pointSize: 10
                        horizontalAlignment: Text.AlignLeft
                        wrapMode: Text.WordWrap
                        text: qsTr("Status:")
                    }

                    Text
                    {
                        id: downloadStatus
                        anchors.top: channelLb.top
                        anchors.left: downloadStatusLb.left
                        color: statusColor(downloadStatus.text)
                        font.pointSize: 10
                        horizontalAlignment: Text.AlignLeft
                        wrapMode: Text.WordWrap
                        text: DownloadStatus
                    }

                    Button
                    {
                        id: btnDelete
                        width: 30
                        height: 30
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.rightMargin: 15
                        anchors.topMargin: 15
                        background: Rectangle
                        {
                            color: "white"
                            radius: width*0.5
                            border.color: "#ff4967"
                            border.width: 1
                            Image
                            {
                                source: "qrc:/images/delete.png"
                            }
                        }
                        onClicked:
                        {
                            downloadsList.model.deleteDownloadFromList(index);
                            downloadsList.model.resetModel();
                        }
                    }

                    Button
                    {
                        id: btnReload
                        width: 30
                        height: 30
                        anchors.right: btnDelete.left
                        anchors.top: parent.top
                        anchors.rightMargin: 13
                        anchors.topMargin: 15
                        enabled:
                        {
                            if (downloadStatus.text == "Error")
                            {
                                return true;
                            }
                            else return false
                        }
                        background: Rectangle
                        {
                            color: btnReload.enabled ? "#4e5f68" : "#aaaaaa"
                            radius: width*0.5
                            Image
                            {
                                source: "qrc:/images/reload.png"
                            }
                        }
                    }

                    Button
                    {
                        id: btnPlayPause
                        width: 30
                        height: 30
                        anchors.right: btnReload.left
                        anchors.top: parent.top
                        anchors.rightMargin: 13
                        anchors.topMargin: 15
                        enabled:
                        {
                            if (downloadStatus.text == "Downloading" || downloadStatus.text == "Pause")
                            {
                                return true;
                            }
                            else return false
                        }
                        background: Rectangle
                        {
                            color: btnPlayPause.enabled ? "#4e5f68" : "#aaaaaa"
                            radius: width*0.5
                            Image
                            {
                                source:
                                {
                                    if (downloadStatus.text == "Downloading")
                                    {
                                        return "qrc:/images/pause.png"
                                    }
                                    else return "qrc:/images/play.png"
                                }
                            }
                        }
                        onClicked: downloadsList.model.pauseDownload(index);
                    }

                    ProgressBar {
                        id: downloadProgressBar
                        from: 0
                        to: 100
                        value: DownloadPercent
                        padding: 2
                        width: 786
                        anchors.left: channelLb.left
                        anchors.top: channelLb.bottom
                        anchors.topMargin: 13

                        background: Rectangle {
                            implicitWidth: 200
                            implicitHeight: 6
                            color: "#e6e6e6"
                            radius: 3
                        }

                        contentItem: Item {
                            implicitWidth: 200
                            implicitHeight: 4

                            Rectangle {
                                width: downloadProgressBar.visualPosition * parent.width
                                height: parent.height
                                radius: 2
                                color: statusColor(downloadStatus.text)
                            }
                        }
                    }

                    Text
                    {
                        id: downloadPercent
                        anchors.top: channelLb.bottom
                        anchors.left: downloadProgressBar.right
                        anchors.topMargin: 8
                        anchors.leftMargin: 15
                        color: statusColor(downloadStatus.text)
                        font.pointSize: 10
                        horizontalAlignment: Text.AlignLeft
                        wrapMode: Text.WordWrap
                        text: DownloadPercent + "%"
                    }

                    Canvas
                    {
                        id: dashedLine
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.leftMargin: 15
                        width: parent.width
                        height: 2
                        onPaint:
                        {
                            var ctx = getContext("2d");
                            ctx.strokeStyle = "#c8c8c8";
                            ctx.lineWidth = 2;
                            ctx.beginPath();
                            ctx.setLineDash([2, 1]);
                            ctx.moveTo(0, 0);
                            ctx.lineTo(width, 0);
                            ctx.stroke();
                        }
                    }
                }
            }
        }
    }


    Rectangle
    {
        id: bottomRow
        color: "transparent"
        height: 61
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        Canvas
        {
            id: solidLine
            anchors.top: parent.top
            anchors.left: parent.left
            width: parent.width
            height: 2
            onPaint:
            {
                var ctx = getContext("2d");
                ctx.strokeStyle = "#c8c8c8";
                ctx.lineWidth = 2;
                ctx.beginPath();
                ctx.moveTo(0, 0);
                ctx.lineTo(width, 0);
                ctx.stroke();
            }
        }

        Button
        {
            anchors.left: parent.left
            anchors.leftMargin: 23
            anchors.verticalCenter: parent.verticalCenter
            width: 105
            height: 30
            background: Rectangle
            {
                color: "transparent"
                Text
                {
                    font.pointSize: 10
                    color: "#4e5f68"
                    text: qsTr("Clear history")
                }
            }
            onClicked:
            {
                downloadsList.model.clearDownloadList();
                downloadsList.model.resetModel();
            }
        }

        Button
        {
            anchors.right: parent.right
            anchors.rightMargin: 17
            anchors.verticalCenter: parent.verticalCenter
            width: 105
            height: 30
            background: Rectangle
            {
                id: btnClose
                color: "#4e5f68"
                radius: 10
                Text
                {
                    anchors.horizontalCenter: btnClose.horizontalCenter
                    anchors.verticalCenter: btnClose.verticalCenter
                    font.pointSize: 10
                    color: "#ffffff"
                    text: qsTr("Close")
                }
            }
            onClicked: root.close()
        }
    }

}
