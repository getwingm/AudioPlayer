import QtQuick 2.0
import QtQuick.Layouts 1.0

Rectangle {
    id: root

    signal playPause
    signal previous
    signal next
    signal seek(real pos)
    signal openFile
    property alias coverSourse: albumCover.source
    property int durationInt
    property string albumTitle: ""
    property string artist: ""
    property string title: ""

    function changePosition(time){
        position.text = millsecToStr(time)
        slider.changePosition(time/root.durationInt)
    }

    function millsecToStr(time){
        var intsec = Math.round((time%60000)/1000)
        var sec = intsec<10 ? "0"+intsec.toString() : intsec.toString()

        return Math.round(time/60000).toString()+":"+sec
    }

    function setDuration(time){
        durationInt = time
        duration.text = millsecToStr(time)
    }

    function setPlaying(isPlaying){
        if(isPlaying)
            playButton.iconSource = "images/icon-pause.png"
        else
            playButton.iconSource = "images/icon-play.png"
    }

    onAlbumTitleChanged: albumTitleText.text = "Album: " + albumTitle
    onArtistChanged: artistText.text = "Artist: " + artist
    onTitleChanged: titleText.text = "Name: " + title

    width: 480
    height: 640
    anchors.fill: parent
    visible: true
    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#000000"
        }

        GradientStop {
            position: 1
            color: "#320000"
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
            onClicked: root.previous()
        }
        Button {
            id:playButton
            iconSource: "images/icon-play.png"
            onClicked: {
                root.playPause()
            }
        }
        Button {
            id:forwardButton
            iconSource: "images/icon-next.png"
            onClicked: root.next()
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
            onPositionChange: root.seek(pos)
        }
    }

    Image {
        id: albumCover
        y: 133
        width: 100
        height: 100
        anchors.horizontalCenterOffset: 0
        anchors.bottom: position.top
        anchors.bottomMargin: 170
        anchors.horizontalCenter: parent.horizontalCenter
        source: "images/icon-album-cover.png"
    }

    Text {
        id: position
        color: "#ffffff"
        text: "0:00"
        anchors.bottom: sliderLayout.top
        anchors.bottomMargin: 20
        font.pointSize: 16
        anchors.left: parent.left
        anchors.leftMargin: 0
    }

    Text{
        id:duration
        color: "#ffffff"
        text: "0:00"
        anchors.bottom: sliderLayout.top
        anchors.bottomMargin: 20
        font.pointSize: 16
        anchors.right: parent.right
        anchors.rightMargin: 0
        }

    Text {
        id: albumTitleText
        color: "#ffffff"
        text: "Album: "
        anchors.bottom: artistText.top
        anchors.bottomMargin: 20
        font.pointSize: 16
        anchors.left: parent.left
        anchors.leftMargin: 0
    }
    Text {
        id: artistText
        color: "#ffffff"
        text: "Artist: "
        anchors.bottom: titleText.top
        anchors.bottomMargin: 20
        font.pointSize: 16
        anchors.left: parent.left
        anchors.leftMargin: 0
    }
    Text {
        id: titleText
        color: "#ffffff"
        text: "Title: "
        anchors.bottom: position.top
        anchors.bottomMargin: 20
        font.pointSize: 16
        anchors.left: parent.left
        anchors.leftMargin: 0
    }

    MouseArea {
        id: mouseArea1
        anchors.bottom: albumTitleText.top
        anchors.bottomMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        onClicked: root.openFile()
    }
}
