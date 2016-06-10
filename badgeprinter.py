#!/usr/bin/env python
# -'''- coding: utf-8 -'''-
 
import sys
import subprocess
from PySide.QtCore import *
from PySide.QtGui import *
from PySide.QtDeclarative import *
import PIL
import PIL.Image
import sqlite3
import random 
from time import sleep
import os

os.chdir(os.path.dirname(os.path.realpath(__file__)))

class MyHandler(QObject):
    

    def __init__(self, window, app, *args, **kwargs):
        QObject.__init__(self, *args, **kwargs)
        self.window = window
        self.app = app
        self.conn = sqlite3.connect('badges.db')
        c = self.conn.cursor()
        c.execute(""" CREATE TABLE IF NOT EXISTS badges (created datetime, name text, twitter text, ticket text) """)
        self.conn.commit()

    def get_ticket_number(self):
        c = self.conn.cursor()
        while True:
            ticket = "%04d" % random.randint(1,9999)
            c.execute(""" SELECT count(*) FROM badges WHERE ticket=? """, (ticket,))
            if c.fetchone()[0] == 0:
                c.close()
                return ticket

    @Slot()
    def run(self):

        inputTwitter = window.rootObject().findChild(QObject, 'inputTwitter')
        inputTwitter.select(0,0)
        if inputTwitter.property('text') == "@twitter" or len(inputTwitter.property("text")) < 1:
            inputTwitter.setProperty("visible", False)
            
        inputName = window.rootObject().findChild(QObject, 'inputName')
        inputName.select(0,0)

        checkboxSelected = window.rootObject().findChild(QObject, 'checkboxSelected').property('visible')
        
        label = window.rootObject().findChild(QObject, 'textLos')

        ticket = ''
        if checkboxSelected:
            ticket = self.get_ticket_number()
            label.setProperty("text", "Los #%s" % ticket)
            #label.setProperty("visible", True)

        inputName.setProperty('focus', False)
        inputTwitter.setProperty('focus', False)

        badge = window.rootObject().findChild(QObject, 'badge')
        image = QPixmap.grabWidget(window, badge.x(), badge.y(), badge.width(), badge.height())

        window.rootObject().findChild(QObject, "animateNameBadgeOff").start()

        self.app.processEvents(QEventLoop.AllEvents, 2000)

        bytes = QByteArray()
        buffer = QBuffer(bytes)
        buffer.open(QIODevice.WriteOnly)
        image.save(buffer, "PNG")

        density = 284  / (38.0/50.0)
        convert = subprocess.Popen(['convert', '-density', '%d' % density,  '-quality', '100', 'png:-', '-gravity', 'center',  '-resize', '2430x1420!', '/tmp/badge.pdf'], stdin=subprocess.PIPE)
        convert.communicate(bytes.data())
        lpr = subprocess.Popen(['lpr', '-PBrother_QL-710W', '-o', 'fit-to-page', '/tmp/badge.pdf'])
        lpr.communicate()
        #convert.stdout.close()
        #convert.wait()#
        
        c = self.conn.cursor()
        c.execute(""" INSERT INTO badges (created, name, twitter,
        ticket) VALUES (datetime('now'),?,?,?) """,
                  (inputName.property('text'), inputTwitter.property('text'),
                   ticket))
        self.conn.commit()
        c.close()
        QTimer.singleShot(2000, lambda: self.reset_ui())

    def reset_ui(self):
        label = window.rootObject().findChild(QObject, 'textLos')
        inputName = window.rootObject().findChild(QObject, 'inputName')
        inputTwitter = window.rootObject().findChild(QObject, 'inputTwitter')
        
        inputTwitter.setProperty("visible", True)
        inputTwitter.setProperty('text', "@twitter")
        inputName.setProperty('text', "Vorname")
        inputName.selectAll()
        inputName.setProperty('focus', True)
        label.setProperty("text", "Los #XXXX")
        window.rootObject().findChild(QObject, 'checkboxSelected').setProperty("visible", True)
        window.rootObject().findChild(QObject, 'printButtonArea').setProperty('enabled', True)
        window.rootObject().findChild(QObject, "animateNameBadgeOn").start()

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
    window.setWindowFlags(Qt.FramelessWindowHint)
    handler = MyHandler(window, app)
    window.rootContext().setContextProperty("handler", handler)
    window.rootObject().findChild(QObject, 'inputName').selectAll()
    window.showFullScreen()
    # Run the main Qt loop
    sys.exit(app.exec_())
