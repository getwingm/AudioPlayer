import QtQuick 2.0
import QtQuick.Layouts 1.0


Rectangle {
    id: rectangle1
    width: 70
    height: 50
    radius: 5
    border.width: 2
    Layout.fillWidth: true

    signal clicked
    property alias iconSource: image.source

    gradient: Gradient {
        GradientStop {
            id: gradientStop1
            color: "#856868"

        }
        GradientStop {
            id: gradientStop2
            color: "#540202"
        }
    }

    states: [
        State {
            name: "Release"
            PropertyChanges {
                target: gradientStop1
                position: 0
            }
            PropertyChanges {
                target: gradientStop2
                position: 1
            }
        },
        State {
            name: "Press"
            PropertyChanges {
                target: gradientStop1
                position: 1
            }
            PropertyChanges {
                target: gradientStop2
                position: 0
            }
        }
    ]
    state: "Release"

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: parent.clicked()
        onPressed: parent.state = "Press"
        onReleased: parent.state = "Release"
    }

    Image {
        id: image
        width: 32
        height: 32
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        source: "qrc:/qtquickplugin/images/template_image.png"
    }
}
