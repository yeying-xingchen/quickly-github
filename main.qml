import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import RinUI

Window {
    id : mainWindow
    width: 640
    height: 480
    visible: true
    title: qsTr("QuicklyGithub")
    
    // 存储加速器类型列表
    property var acceleratorTypes: []
    property var msg: ""
    property bool linkHandlerReady: typeof linkHandler !== 'undefined'

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        text: qsTr("QuicklyGithub")
        font.pixelSize: 48
        font.bold: true
        color: "#2c3e50"
        anchors.top: parent.top
        anchors.topMargin: 30
    }

    // 使用 GridLayout 创建更整齐的表单
    GridLayout {
        anchors.centerIn: parent
        columns: 3
        rowSpacing: 10
        columnSpacing: 10
        width: parent.width * 0.8
        
        // 链接标签和输入框
        Label {
            text: qsTr("链接：")
            Layout.alignment: Qt.AlignRight
        }
        TextField {
            id: linkField
            placeholderText: qsTr("请输入需要加速的链接")
            Layout.fillWidth: true
        }
        
        // 添加下拉菜单
        ComboBox {
            id: acceleratorType
            model: linkHandlerReady ? 
                   (acceleratorTypes.length > 0 ? acceleratorTypes : linkHandler.getAcceleratorTypes()) : 
                   ["等待加载..."]
            Layout.fillWidth: true
            currentIndex: 0
        }
        
        // 提交按钮（跨三列）
        Item {
            Layout.columnSpan: 3
            Layout.fillWidth: true
            height: 10
        }
        
        Button {
            highlighted: true
            text: qsTr("开始加速")
            Layout.fillWidth: true
            Layout.columnSpan: 3
            enabled: linkHandlerReady
            onClicked: {
                if (linkHandlerReady) {
                    mainWindow.msg = linkHandler.openRepository(linkField.text, acceleratorType.currentText);
                    dialog.open();
                } else {
                    mainWindow.msg = "链接处理器尚未就绪，请稍后再试";
                    dialog.open();
                }
            }

            Dialog {
                id: dialog
                title: qsTr("提示")
                modal: true
                Text {
                    text: qsTr("加速链接已在浏览器中打开。您的加速链接为：\n") + mainWindow.msg
                }
                standardButtons: Dialog.Ok
            }
        }

        Button {
            text: qsTr("重新检测镜像延迟")
            Layout.fillWidth: true
            Layout.columnSpan: 3
            enabled: linkHandlerReady
            onClicked: {
                if (linkHandlerReady) {
                    acceleratorTypes = linkHandler.getAcceleratorTypesPing();
                } else {
                    console.log("linkHandler not ready yet");
                }
            }
        }
    }
}