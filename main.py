import sys
import webbrowser
from PySide6.QtWidgets import QApplication
from PySide6.QtCore import QObject, Slot

from RinUI import RinUIWindow


class LinkHandler(QObject):
    @Slot(str)
    def openRepository(self, url):
        """打开仓库链接"""
        if not url.startswith(('http://', 'https://')):
            url = 'https://' + url
        webbrowser.open(url)


if __name__ == '__main__':
    app = QApplication(sys.argv)
    # 创建链接处理器
    link_handler = LinkHandler()
    # 创建主窗口
    main = RinUIWindow("main.qml")
    # 尝试注册到 QML 上下文
    if hasattr(main, 'rootContext'):
        main.rootContext().setContextProperty("linkHandler", link_handler)
    app.exec()
