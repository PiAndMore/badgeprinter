#!/usr/bin/env python
# -'''- coding: utf-8 -'''-
 
import sys
import subprocess
from PySide.QtCore import *
from PySide.QtGui import *
from PySide.QtDeclarative import *
import PIL
import PIL.Image

class MyHandler(QObject):
    

    def __init__(self, window, *args, **kwargs):
        QObject.__init__(self, *args, **kwargs)
        self.window = window

    @Slot()
    def run(self):
        
        inputTwitter = window.rootObject().findChild(QObject, 'inputTwitter')
        inputTwitter.select(0,0)
        if inputTwitter.property('text') == "@twitter" or len(inputTwitter.property("text")) < 1:
            inputTwitter.setProperty("visible", False)
            
        window.rootObject().findChild(QObject, 'inputName').select(0,0)

        msgBox = QMessageBox()
        msgBox.setWindowTitle(u"Teilnahme an der Verlosung?")
        msgBox.setText(u"Möchten Sie an der Verlosung teilnehmen?")
        msgBox.setIcon(QMessageBox.Question)
        msgBox.setInformativeText(u"Am Ende der Veranstaltung werden unter allen Anwesenden Sachpreise verlost (Bücher, Gadgets, etc.). Ihr Namensschild ist das Los.")
        msgBox.setStandardButtons(QMessageBox.Yes | QMessageBox.No | QMessageBox.Abort)
        msgBox.setDefaultButton(QMessageBox.Yes)
        msgBox.setEscapeButton(QMessageBox.Abort)

        mboxres = msgBox.exec_()
        
        if mboxres == QMessageBox.Yes:
            label = window.rootObject().findChild(QObject, 'textLos')
            label.setProperty("text", "Los #1234")
            label.setProperty("visible", True)
        elif mboxres != QMessageBox.No:
            return


        badge = window.rootObject().findChild(QObject, 'badge')
        image = QPixmap.grabWidget(window, badge.x(), badge.y(), badge.width(), badge.height())
        print repr(badge)
        #image.save("/tmp/test.png", "PNG")
        bytes = QByteArray()
        buffer = QBuffer(bytes)
        buffer.open(QIODevice.WriteOnly)
        image.save(buffer, "PNG")
        
        p = subprocess.Popen(['convert', '-density', '284',  '-quality', '100', 'png:-', '-gravity', 'center',  '-resize', '2430x1420!', '/tmp/test.pdf'], stdin=subprocess.PIPE)
        p.communicate(bytes.data())


# Our main window
class MainWindow(QDeclarativeView):
 
    def __init__(self, parent=None):
        super(MainWindow, self).__init__(parent)
        self.setWindowTitle("Main Window")
        # Renders 'view.qml'
        self.setSource(QUrl.fromLocalFile('view.qml'))
        # QML resizes to main window
        self.setResizeMode(QDeclarativeView.SizeRootObjectToView)
 
if __name__ == '__main__':
    # Create the Qt Application
    app = QApplication(sys.argv)
    # Create and show the main window
    window = MainWindow()
    handler = MyHandler(window)
    window.rootContext().setContextProperty("handler", handler)
    window.rootObject().findChild(QObject, 'inputName').selectAll()
    window.show()
    # Run the main Qt loop
    sys.exit(app.exec_())
