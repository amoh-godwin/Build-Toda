import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Component {

    Rectangle {
        id: taskItem
        width: parent.width
        height: !expanded ? 48 : (tArea.height + 96) > 128 ? tArea.height + 96 : 128
        radius: 8
        color: "#222231"

        property bool expanded: false

        ColumnLayout {
            width: parent.width
            height: parent.height
            spacing: 0

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 48
                color: "transparent"

                RowLayout {
                    anchors.fill: parent
                    spacing: 0

                    Rectangle {
                        Layout.leftMargin: 18
                        width: 13
                        height: 13
                        radius: height / 2
                        color: "transparent"
                        border.color: rand_color[ind % 7]
                        border.width: 1
                    }

                    Column {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.topMargin: 18

                        Text {
                            text: title
                            leftPadding: 18
                            //horizontalAlignment: Text.AlignLeft
                            color: "white"
                        }

                        Text {
                            text: "Project: " + section
                            color: "#727272"
                            leftPadding: 18
                            visible: taskItem.expanded
                        }

                    }

                    IconicButton {
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                        Layout.rightMargin: 18
                        color: "#727272"
                        text: "\uf1d8"

                        onClicked: {
                            taskItem.expanded = !taskItem.expanded
                        }

                    }

                }

            }

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.leftMargin: 18
                color: "transparent"
                visible: taskItem.expanded

                TextArea {
                    id: tArea
                    width: parent.width
                    selectByMouse: true
                    selectionColor: "orange"
                    selectedTextColor: "white"
                    padding: 0
                    topPadding: 6
                    font.pixelSize: 12
                    color: "#727272"
                    cursorDelegate: Component {
                        Rectangle {
                            width: 1
                            height: 1
                            color: "transparent"
                        }
                    }
                }

            }

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 48
                Layout.alignment: Qt.AlignBottom
                color: "transparent"
                visible: taskItem.expanded

                Row {
                    spacing: 8

                    anchors {
                        top: parent.top
                        bottom: parent.bottom
                        right: parent.right
                        topMargin: 18
                        bottomMargin: 18
                        rightMargin: 18
                    }


                    Text {
                        font.family: mainFont.name
                        font.pixelSize: 20
                        color: "#727272"
                        text: "\uf150"
                    }

                    Text {
                        font.family: mainFont.name
                        font.pixelSize: 20
                        color: "#727272"
                        text: "\ufc92"
                    }

                    Text {
                        font.family: mainFont.name
                        font.pixelSize: 20
                        color: "#727272"
                        text: "\ufb42"
                    }

                    Text {
                        font.family: mainFont.name
                        font.pixelSize: 20
                        color: "#727272"
                        text: "\uf224"
                    }

                }

            }

        }

    }

}
