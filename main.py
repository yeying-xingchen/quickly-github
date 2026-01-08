import sys
import webbrowser
import requests
from PySide6.QtWidgets import QApplication
from PySide6.QtCore import QObject, Slot

from RinUI import RinUIWindow

resp = requests.get("https://raw.githubusercontent.com/yeying-xingchen/quickly-github/refs/heads/main/data/proxy.json")
data = resp.json()

class LinkHandler(QObject):
    @Slot(str, str)
    def openRepository(self, url, accelerator_type):
        """打开仓库链接"""
        if not url.startswith(('http://', 'https://')):
            url = 'https://' + url
        
        for item in data["github_proxy"]:
            if item["name"] == accelerator_type:
                accelerator_type = item["proxy"]
                break
        processed_url = self._apply_accelerator(url, accelerator_type)
        webbrowser.open(processed_url)
        return processed_url
    
    def _apply_accelerator(self, url, accelerator_type):
        """应用加速器到 URL"""
        base_url = accelerator_type
        return base_url + url


    @Slot(result=list)
    def getAcceleratorTypes(self):
        """返回加速器类型列表"""
        for item in data["github_proxy"]:
            proxy_list = []
            proxy_list.append(item["name"])
        return proxy_list


if __name__ == '__main__':
    app = QApplication(sys.argv)
    # 创建链接处理器
    link_handler = LinkHandler()
    # 创建主窗口
    main = RinUIWindow("main.qml")
    # 尝试注册到 QML 上下文
    main.engine.rootContext().setContextProperty("linkHandler", link_handler)
    app.exec()