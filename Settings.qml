import QtQuick 2.0

Rectangle {
    id: root
    width: 300
    height: 640
    color: "#372e2e"
    border.color: "#00000000"
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 0
    anchors.top: parent.top
    anchors.topMargin: 0
    property bool random: false
    property string repeat: "seq"
    property alias closeAreaWidth: closeArea.width
    signal openFilesClicked
    signal openDirectoryClicked
    signal closeClicked
    //state: "seq", "loop", "loopone", "once"

    function changeRandom(){
        if(random){
            randomButton.icon = "images/icon-randomblack.png"
            randomButton.text = qsTr("Random: off")
            random = false
        }else{
            randomButton.icon = "images/icon-random.png"
            randomButton.text = qsTr("Random: on")
            random = true
        }
    }

    function changeRepeat(){
        if(repeat == "seq"){
            repeatButton.text = qsTr("Loop all")
            repeatButton.icon = "images/icon-loop.png"
            repeat = "loop"
        }else if(repeat == "loop"){
            repeatButton.text = qsTr("Loop one")
            repeatButton.icon = "images/icon-loopone.png"
            repeat = "loopone"
        }else if(repeat == "loopone"){
            repeatButton.text = qsTr("Current once")
            repeatButton.icon = "images/icon-once.png"
            repeat = "once"
        }else{
            repeatButton.text = qsTr("Sequential")
            repeatButton.icon = "images/icon-loopblack.png"
            repeat = "seq"
        }
    }

    SettingButton {
        id: openFilesButton
        y: 40
        text: qsTr("Open Files...")
        icon: "images/icon-addfile.png"
        onClicked: {
            root.closeClicked()
            root.openFilesClicked()
        }
    }

    SettingButton {
        id: openDirectoryButton
        text: qsTr("Open Directory...")
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: openFilesButton.bottom
        anchors.topMargin: 0
        icon: "images/icon-addfolder.png"
        onClicked: {
            root.openDirectoryClicked()
            root.closeClicked()
        }
    }

    SettingButton {
        id: repeatButton
        text: qsTr("Sequential")
        anchors.top: openDirectoryButton.bottom
        anchors.topMargin: 100
        icon: "images/icon-loopblack.png"
        onClicked: root.changeRepeat()
    }

    SettingButton {
        id: randomButton
        text: qsTr("Random: off")
        anchors.top: repeatButton.bottom
        anchors.topMargin: 0
        icon: "images/icon-randomblack.png"
        onClicked: root.changeRandom()
    }

    MouseArea{
        id:closeArea
        anchors.left: root.right
        anchors.top: root.top
        anchors.bottom: root.bottom
        onClicked: root.closeClicked()
    }
}

