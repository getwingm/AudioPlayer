import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.0
import QtMultimedia 5.0

Window {
    id: window1
    visible: true
    color: "gray"
    width: 360
    height: 480

    Audio{
        id:player
        source: "file:///mnt/sdcard/Sounds/Nirvana - Smells Like Teen Spirit.mp3"
        onPlaying: timer.start()
        onPaused: timer.stop()
        onStopped: timer.stop()
        onError: timer.stop()
    }

    Rectangle {
        id: rectangle1
        //width: 360
        //height: 480
        color: "#513333"
        //anchors.verticalCenter: parent.verticalCenter
        //anchors.horizontalCenter: parent.horizontalCenter
        anchors.fill: parent
        visible: true
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#513333"
            }

            GradientStop {
                position: 1
                color: "#000000"
            }
        }
        RowLayout {
            id: buttonLayout
            height: 50
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 40
            anchors.left: parent.left
            anchors.right: parent.right
            Button {
                id:backButton
                iconSource: "images/icon-previous.png"
            }
            Button {
                id:playButton
                iconSource: "images/icon-play.png"
                onClicked: {
                    player.play()
                    albumCover.source = player.metaData.coverArtUrlLarge
                }
            }
            Button {
                id:forwardButton
                iconSource: "images/icon-next.png"
            }

        }

        RowLayout {
            id: sliderLayout
            height: 62
            anchors.bottom: buttonLayout.top
            anchors.bottomMargin: 40
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            ProgressSlider{
                id: slider
                onPositionChange: player.seek(player.duration * pos)
            }
        }

        Image {
            id: albumCover
            width: 100
            height: 100
            anchors.top: parent.top
            anchors.topMargin: 40
            anchors.horizontalCenter: parent.horizontalCenter
            source: "images/icon-album-cover.png"
        }
        Timer{
            id: timer
            interval: 1000
            repeat: true
            onTriggered: slider.changePosition(player.position / player.duration)
        }
    }

}
