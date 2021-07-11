import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtQuick.Dialogs 1.3
import "controls"

Window {
    id: mainWindow
    width: 1000
    height: 580
    minimumWidth: 800
    minimumHeight: 500
    visible: true
    color: "#00000000"
    title: qsTr("Course")

    flags: Qt.Window | Qt.FramelessWindowHint

    property alias actualPage: stackView.currentItem

    //Properties
    property int windowStatus: 0
    property int windowMargin: 10

    //internal function
    QtObject {
        id : internal

        function resizeBorders() {
            resizeLeft.visible = true
            resizeRight.visible = true
            resizeWindow.visible = true
            resizeBottom.visible = true
        }

        function maximiziRestore() {
            if(windowStatus == 0) {
                mainWindow.showMaximized()
                windowStatus = 1
                windowMargin = 0
                //rsize visibility
                resizeLeft.visible = false
                resizeRight.visible = false
                resizeWindow.visible = false
                resizeBottom.visible = false
                btnMaximizeRestore.btnIconSource = "qrc:/images/svg_images/restore_icon.svg"
            } else {
                mainWindow.showNormal()
                windowStatus = 0
                windowMargin = 10
                //rsize visibility
                internal.resizeBorders()
                btnMaximizeRestore.btnIconSource = "qrc:/images/svg_images/maximize_icon.svg"
            }
        }

        function ifMaximmizedWindowRestore () {
            if(windowStatus == 1) {
                mainWindow.showNormal()
                windowStatus = 0
                windowMargin = 10
                btnMaximizeRestore.btnIconSource = "qrc:/images/svg_images/maximize_icon.svg"
                //rsize visibility
                internal.resizeBorders()
            }
        }

        function restoreMargins() {
            windowStatus = 0
            windowMargin = 10
            //rsize visibility
            internal.resizeBorders()
            btnMaximizeRestore.btnIconSource = "qrc:/images/svg_images/maximize_icon.svg"
        }

    }

    Rectangle {
        id: bg
        color: "#2c313c"
        border.color: "#383e4c"
        border.width: 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: windowMargin
        anchors.leftMargin: windowMargin
        anchors.bottomMargin: windowMargin
        anchors.topMargin: windowMargin
        z : 1

        Rectangle {
            id: appContainer
            color: "#00000000"
            anchors.fill: parent
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            anchors.bottomMargin: 1
            anchors.topMargin: 1

            Rectangle {
                id: topBar
                height: 60
                color: "#1c1d20"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0

                ToggleButton {
                    onClicked: animationMenu.running = true
                }

                Rectangle {
                    id: topBarDescription
                    y: 28
                    height: 25
                    color: "#282c34"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.leftMargin: 70
                    anchors.bottomMargin: 0

                    Label {
                        id: labelTopinfo
                        color: "#5f6a82"
                        text: qsTr("Application Description")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        verticalAlignment: Text.AlignVCenter
                        anchors.bottomMargin: 0
                        anchors.rightMargin: 300
                        anchors.leftMargin: 10
                        anchors.topMargin: 0
                    }

                    Label {
                        id: labelRightinfo
                        color: "#5f6a82"
                        text: qsTr("|HOME")
                        anchors.left: labelTopinfo.right
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        horizontalAlignment: Text.AlignRight
                        verticalAlignment: Text.AlignVCenter
                        anchors.bottomMargin: 0
                        anchors.rightMargin: 10
                        anchors.leftMargin: 0
                        anchors.topMargin: 0
                    }
                }

                Rectangle {
                    id: titleBar
                    height: 35
                    color: "#00000000"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 105
                    anchors.leftMargin: 70
                    anchors.topMargin: 0

                    DragHandler {
                        onActiveChanged: if(active) {
                                             mainWindow.startSystemMove()
                                             internal.ifMaximmizedWindowRestore()
                                         }
                    }

                    Image {
                        id: iconeApp
                        width: 22
                        height: 22
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        source: "../images/svg_images/icon_app_top.svg"
                        anchors.leftMargin: 5
                        anchors.bottomMargin: 0
                        anchors.topMargin: 0
                        fillMode: Image.PreserveAspectFit
                    }

                    Label {
                        id: label
                        color: "#c3cbdd"
                        text: qsTr("My Application title")
                        anchors.left: iconeApp.right
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: 10
                        anchors.leftMargin: 5
                    }
                }

                Row {
                    id: rowBtn
                    width: 105
                    height: 35
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.rightMargin: 0

                    TopBarButton {
                        id: btnMinimize
                        btnIconSource: "qrc:/images/svg_images/minimize_icon.svg"
                        onClicked: {

                            mainWindow.showMinimized()
                            internal.restoreMargins()
                        }
                    }

                    TopBarButton {
                        id: btnMaximizeRestore
                        btnIconSource: "qrc:/images/svg_images/maximize_icon.svg"
                        onClicked: internal.maximiziRestore()

                    }

                    TopBarButton {
                        id: btnClose
                        btnColorClicked: "#f10000"
                        btnIconSource: "qrc:/images/svg_images/close_icon.svg"
                        onClicked: mainWindow.close()
                    }
                }
            }

            Rectangle {
                id: content
                color: "#00000000"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: topBar.bottom
                anchors.bottom: parent.bottom
                anchors.topMargin: 0

                Rectangle {
                    id: leftMenu
                    width: 70
                    color: "#1c1d20"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    clip: true
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0

                    PropertyAnimation{
                        id: animationMenu
                        target: leftMenu
                        property: "width"
                        to: if(leftMenu.width == 70) return 250; else return 70
                        duration: 500
                        easing.type: Easing.InOutQuint
                    }

                    Column {
                        id: column
                        width: 70
                        height: 408
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        clip: true
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                        anchors.bottomMargin: 90
                        anchors.topMargin: 0

                        LeftMenu {
                            id: btnHome
                            width: leftMenu.width
                            text: qsTr("Home")
                            isActiveMenu: true
                            onClicked: {
                                btnSettings.isActiveMenu = false
                                btnHome.isActiveMenu = false
                                stackView.push(Qt.resolvedUrl("qrc:/qml/pages/textEditor.qml"))
                                //pageView.setSource(Qt.resolvedUrl("qrc:/qml/pages/homePage.qml"))

                            }
                        }

                        LeftMenu {
                            id: btnOpen
                            width: leftMenu.width
                            text: qsTr("Open")
                            btnIconSource: "../images/svg_images/open_icon.svg"
                            onPressed: {
                                fileOpen.open()
                            }
                            FileDialog{
                                id: fileOpen
                                title: "Please choose a file"
                                folder: shortcuts.home
                                selectMultiple: false
                                nameFilters: ["Text File (*.txt)"]
                                onAccepted: {
                                    backend.openFile(fileOpen.fileUrl)
                                }
                            }
                        }

                        LeftMenu {
                            id: btnSave
                            width: leftMenu.width
                            text: qsTr("Save")
                            btnIconSource: "../images/svg_images/save_icon.svg"

                            onPressed: {
                                fileSave.open()
                            }

                            FileDialog{
                                id: fileSave
                                title: "Save file"
                                folder: shortcuts.home
                                selectExisting: false
                                nameFilters: ["Text File (*.txt)"]
                                onAccepted: {
                                    backend.getTextField(actualPage.getText)
                                    backend.writeFile(fileSave.fileUrl)
                                }
                            }
                        }
                    }

                    LeftMenu {
                        id: btnSettings
                        width: leftMenu.width
                        text: qsTr("Settings")
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 25
                        btnIconSource: "../images/svg_images/settings_icon.svg"
                        onClicked: {
                            btnHome.isActiveMenu = false
                            btnSettings.isActiveMenu = true
                            stackView.push(Qt.resolvedUrl("qrc:/qml/pages/licensePage.qml"))
                            //pageView.setSource(Qt.resolvedUrl("qrc:/qml/pages/settingsPage.qml"))
                        }
                    }
                }

                Rectangle {
                    id: contentPage
                    color: "#00000000"
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    clip: true
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 25
                    anchors.topMargin: 0

                    StackView {
                        id: stackView
                        anchors.fill: parent
                        initialItem: Qt.resolvedUrl("qrc:/qml/pages/textEditor.qml")
                    }

                    //                    Loader {
                    //                        id : pageHome
                    //                        anchors.fill: parent
                    //                        source: Qt.resolvedUrl("qrc:/qml/pages/homePage.qml")
                    //                        visible: false
                    //                    }
                    //                    Loader {
                    //                        id : pageSettings
                    //                        anchors.fill: parent
                    //                        source: Qt.resolvedUrl("qrc:/qml/pages/settingsPage.qml")
                    //                        visible: true
                    //                    }
                }

                Rectangle {
                    id: rectangle
                    color: "#282c34"
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: contentPage.bottom
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0

                    Label {
                        id: labelTopInfo1
                        color: "#5f6a82"
                        text: qsTr("Application description")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        verticalAlignment: Text.AlignVCenter
                        anchors.topMargin: 0
                        anchors.rightMargin: 30
                        anchors.leftMargin: 10
                        anchors.bottomMargin: 0
                    }

                    MouseArea {
                        id: resizeWindow
                        x: 884
                        y: 0
                        width: 25
                        height: 25
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        opacity: 0.5
                        anchors.rightMargin: 0
                        anchors.bottomMargin: 0
                        cursorShape: Qt.SizeFDiagCursor

                        DragHandler {
                            target: null
                            onActiveChanged: if(active) {
                                                 mainWindow.startSystemResize(Qt.RightEdge | Qt.BottomEdge)
                                             }
                        }

                        Image {
                            id: resizeimage
                            width: 16
                            height: 16
                            anchors.fill: parent
                            source: "../images/svg_images/resize_icon.svg"
                            anchors.leftMargin: 5
                            anchors.topMargin: 5
                            sourceSize.height: 16
                            sourceSize.width: 16
                            fillMode: Image.PreserveAspectFit
                            antialiasing: false
                        }
                    }
                }
            }
        }
    }

    DropShadow {
        anchors.fill: bg
        horizontalOffset: 0
        verticalOffset: 0
        radius: 10
        samples: 16
        color: "#80000000"
        source : bg
        z : 0
    }

    MouseArea {
        id: resizeLeft
        width: 10
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        cursorShape: Qt.SizeHorCursor

        DragHandler {
            target: null
            onActiveChanged: if(active) { mainWindow.startSystemResize(Qt.LeftEdge) }
        }
    }

    MouseArea {
        id: resizeRight
        width: 10
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        cursorShape: Qt.SizeHorCursor

        DragHandler {
            target: null
            onActiveChanged: if(active) { mainWindow.startSystemResize(Qt.RightEdge) }
        }
    }

    MouseArea {
        id: resizeBottom
        height: 10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.bottomMargin: 0
        cursorShape: Qt.SizeVerCursor

        DragHandler {
            target: null
            onActiveChanged: if(active) { mainWindow.startSystemResize(Qt.BottomEdge) }
        }
    }

    /*MouseArea {
        id: resizeTop
        height: 10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.topMargin: 0
        cursorShape: Qt.SizeVerCursor

        DragHandler {
            target: null
            onActiveChanged: if(active) { mainWindow.startSystemResize(Qt.TopEdge) }
        }
    }*/

    Connections{
        target: backend
        function onReadText(text) {
            actualPage.setText = text
        }
    }
}
