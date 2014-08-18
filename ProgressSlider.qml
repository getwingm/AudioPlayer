import QtQuick 2.0
import QtQuick.Layouts 1.0

Rectangle {
    anchors.left: parent.left
    anchors.right: parent.right
    height: 62
    radius: 3
    //border.width: 3
    Layout.fillWidth: true

    signal positionChange(real pos)

    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#675103"
        }

        GradientStop {
            position: 1
            color: "#000000"
        }
    }

    Rectangle {
        id: slider
        radius: 3
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#ffe70a"
            }

            GradientStop {
                position: 1
                color: "#000000"
            }
        }
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
    }

    MouseArea {
        id: mouseArea1
        anchors.fill: parent
        property bool isPressed: false
        onClicked: positionChanged(mouse)
        onPositionChanged: {
            if(mouseX >= 0 && mouseX <= parent.width){
                slider.width = mouseX
                parent.positionChange(slider.width / parent.width)
            }
        }
    }
    function changePosition(pos){
        slider.width = parent.width * pos
    }
}
