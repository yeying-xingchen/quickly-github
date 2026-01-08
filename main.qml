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
        columns: 2
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
        
        // 提交按钮（跨两列）
        Item {
            Layout.columnSpan: 2
            Layout.fillWidth: true
            height: 10
        }
        
        Button {
            highlighted: true
            text: qsTr("开始加速")
            Layout.fillWidth: true
            Layout.columnSpan: 2
            onClicked: {
                if (typeof linkHandler !== 'undefined') {
                    linkHandler.openRepository(linkField.text);
                } else {
                    console.log("Opening repository:", linkField.text);
                }
            }
        }

        Button {
            text: qsTr("开始加速")
            Layout.fillWidth: true
            Layout.columnSpan: 2
            onClicked: {
                if (typeof linkHandler !== 'undefined') {
                    linkHandler.openRepository(linkField.text);
                } else {
                    console.log("Opening repository:", linkField.text);
                }
            }
        }
    }
}