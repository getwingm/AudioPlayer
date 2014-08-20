import QtQuick 2.0

Rectangle {
    signal clicked()
    property alias icon: image.source
    property alias text: label.text

    id: root
    height: 52
    color: "#382e2e"
    border.color: "#785e5e"
    anchors.right: parent.right
    anchors.rightMargin: 0
    anchors.left: parent.left
    anchors.leftMargin: 0
    onWidthChanged: {
        for(var i = 1; i <=33; i++ ){
            label.font.pixelSize = i
            if(label.x + label.width > root.width){
                label.font.pixelSize = i-1
                break
            }
        }
    }

    states: [
        State {
            name: "release"
            PropertyChanges {
                target: root
                color: "#382e2e"
            }
        },
        State {
            name: "press"
            PropertyChanges {
                target: root
                color: "#150e0e"
            }
        }
    ]
    state: "release"

    MouseArea {
        anchors.fill: parent
        onClicked: root.clicked()
        onPressed: root.state = "press"
        onReleased: root.state = "release"
    }

    Image {
        id: image
        width: 32
        height: 32
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 20
        source: "qrc:/qtquickplugin/images/template_image.png"
    }

    Text {
        id: label
        color: "#ffffff"
        styleColor: "#ffffff"
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: image.right
        anchors.leftMargin: 20
    }
}
