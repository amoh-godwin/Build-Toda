import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import "components" as Comp
import "js/app_functions.js" as AppFunc
import toda 1.0

ApplicationWindow {
    visible: true
    width: 360
    height: 600

    onClosing: {
        print('HouseKeeping: About to close')
    }

    TodaStorage {
        id: todaStorage
    }

    FontLoader { id: mainFont; source: "qrc:///res/fonts/materialdesignicons-webfont.ttf"}

    property var rand_color: ["dodgerblue", "#ff424c", "#00c1ed", "#ff9700", "#00a8b0", "yellow", "#00ed06"]
    property var section_ind: {"DESIGN WORK": 0, "TO DO": 2}
    property var sections_list: ["DESIGN WORK", "TO DO"]
    property var base_mode: [{"ind": 0, "section": "DESIGN WORK", "title": "Send final files to Jessica"},
                             {"ind": 1, "section": "DESIGN WORK", "title": "Finish prototype for mobile"},
                             {"ind": 2, "section": "TO DO", "title": "Meet with Nash on morning"},
                             {"ind": 3, "section": "TO DO", "title": "Sync with dev team"}]

    signal insertTask()

    onInsertTask: {
        var nt = new_task

        console.log(nt.title, nt.section, nt.detail)
        var dd = {'ind': 4, 'section': nt.section, 'title': nt.title}

        if (sections_list.indexOf(nt.section) < 0) {
            sections_list.push(nt.section)
            section_ind[nt.section] = base_mode.length
        }

        var ind = section_ind[nt.section]

        base_mode.splice(ind, 0, dd);

        AppFunc.indexSections(ind);

        AppFunc.reAssignIndex();

        lview.model.clear()

        var code_str = JSON.stringify(base_mode);
        console.log(code_str)

        for (var y=0; y<base_mode.length; y++) {
            lview.model.append(base_mode[y])
        }

        // call the update in the backend
        todaStorage.update(code_str)

        //Store.calc(base_mode, nt.title, nt.section, nt.detail)

    }

    Rectangle {
        anchors.fill: parent
        color: "#191928"



        ColumnLayout {
            anchors {
                fill: parent
                leftMargin: 18
                rightMargin: 18
                topMargin: 28
                bottomMargin: 36
            }



            Comp.NormalSearchBar {
                Layout.fillWidth: true
                Layout.preferredHeight: 48
            }



            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 24
                Layout.topMargin: 16
                Layout.bottomMargin: 4
                color: "transparent"

                Text {
                    text: qsTr("Friday, 26")
                    font.family: "Roboto"
                    font.pixelSize: 21
                    color: "white"
                    renderType: Text.NativeRendering
                }

            }

            Rectangle {
                id: new_task
                Layout.fillWidth: true
                Layout.preferredHeight: !expanded ? 48 : (new_task_tArea.height + 96) > 128 ? new_task_tArea.height + 96 : 128
                radius: 8
                color: "#222231"
                visible: false

                property bool expanded: true
                property string title: new_task_title.text
                property string section: new_task_section.text
                property string detail: new_task_tArea.text

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
                                border.color: "#00a8b0"
                                border.width: 1
                            }

                            Column {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                Layout.topMargin: 8
                                Layout.leftMargin: 18
                                spacing: 0

                                Comp.CustTextField {id: new_task_title}

                                Comp.CustTextField {
                                    id: new_task_section
                                    placeholderText: "Project: "
                                    visible: new_task.expanded
                                }

                            }

                            Comp.IconicButton {
                                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                Layout.rightMargin: 18
                                color: "#727272"
                                text: "\uf1d8"

                                onClicked: {
                                    new_task.expanded = !new_task.expanded
                                }

                            }

                        }

                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.leftMargin: 18
                        color: "transparent"
                        visible: new_task.expanded

                        TextArea {
                            id: new_task_tArea
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
                        visible: new_task.expanded

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

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "transparent"

                //Comp.BackupModel {id: bkModel }

                ListView {
                    id: lview
                    anchors.fill: parent
                    spacing: 12
                    model: Comp.BackupModel{}//Comp.TaskModel {}
                    delegate: Comp.Task {}
                    section.property: "section"
                    section.delegate: Comp.TaskSection {}
                    clip: true

                    Component.onCompleted: {
                        for (var i = 0; i < base_mode.length; i++) {
                            lview.model.append(base_mode[i])
                        }
                    }

                }

            }

            Comp.ButtonPrimary {
                Layout.fillWidth: true
                Layout.preferredHeight: 48

                onClicked: {

                    if (this.inserting) {
                        insertTask()
                        new_task_section.text = ""
                        new_task_title.text = ""
                        new_task_tArea.text = ""
                        new_task.visible = false
                        this.inserting = false
                    } else {
                        this.inserting = true
                        new_task.visible = true
                    }

                }

            }


        }

    }

    Connections {
        target: Store

        onUpdated: {
            var ret_list = updateList
            base_mode = ret_list
            lview.model.clear()

            for (var x=0; x<base_mode.length; x++) {
                lview.model.append(base_mode[x])
            }

        }
    }

}
