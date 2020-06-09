import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Rectangle {

    radius: 8
    color:"#222231"

    RowLayout {
        spacing: 8

        anchors {
            fill: parent
            leftMargin: 6
            rightMargin: 18
        }

        IconicButton {
            text: "\uf35c"
            color: "white"
            textSize: 20
        }

        Text {
            Layout.fillWidth: true
            text: "Search task"
            font.pixelSize: 12
            color: "white"
        }

        Rectangle {
            width: 24
            height: 24
            radius: height / 2
            //color: "transparent"

            RoundImage {
                anchors.fill: parent
                source: "../../images/prof-pic.jpg"
            }


        }

    }

}
