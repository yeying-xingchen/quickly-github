import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import RinUI

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("QuicklyGithub")
    
    // 存储加速器类型列表
    property var acceleratorTypes: []

    property var msg: ""

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
            model: acceleratorTypes.length > 0 ? acceleratorTypes : ["获取镜像中..."] // 默认值
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
            onClicked: {
                msg = linkHandler.openRepository(linkField.text, acceleratorType.currentText);
                dialog.open();
            }
        }

        Dialog {
            id: alert
            title: qsTr("提示")
            Text {
                text: msg
            }
            standardButtons: Dialog.Ok
        }

        Button {
            text: qsTr("获取镜像列表")
            Layout.fillWidth: true
            Layout.columnSpan: 3
            onClicked: {
                acceleratorTypes = linkHandler.getAcceleratorTypes();
            }
        }
    }
}