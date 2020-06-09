import QtQuick 2.10
import QtGraphicalEffects 1.0

Rectangle {
    id: rect
    color: "transparent"

    property url source

    OpacityMask {
        anchors.fill: parent
        source: img_src
        maskSource: mask
    }

    Image {
        id: img_src
        sourceSize: Qt.size(parent.width, parent.height)
        //fillMode: Image.PreserveAspectCrop
        source: rect.source
        smooth: true
        visible: false
    }

    Image {
        id: mask
        sourceSize: Qt.size(parent.width, parent.height)
        source: "../../images/mask-24.png"
        smooth: true
        visible: false
    }

}
