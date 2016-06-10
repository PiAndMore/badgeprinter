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

class MyHandler(QObject):
    

    def __init__(self, window, *args, **kwargs):
        QObject.__init__(self, *args, **kwargs)
        self.window = window
        self.conn = sqlite3.connect('badges.db')
        c = self.conn.cursor()
        c.execute(""" SELECT ticket FROM badges WHERE ticket != ''""")
        tickets = []
        for t in c.fetchall():
            tickets.append(t[0])
        random.shuffle(tickets)
        self.tickets = tickets
        

    @Slot(QObject)
    def run(self, target):
        target.setProperty('text', self.tickets.pop())
        
            

# Our main window
class MainWindow(QDeclarativeView):
 
    def __init__(self, parent=None):
        super(MainWindow, self).__init__(parent)
        self.setWindowTitle("Main Window")
        # Renders 'view.qml'
        self.setSource(QUrl.fromLocalFile('shuffler-view.qml'))
        # QML resizes to main window
        self.setResizeMode(QDeclarativeView.SizeRootObjectToView)
 
if __name__ == '__main__':
    # Create the Qt Application
    app = QApplication(sys.argv)
    # Create and show the main window
    window = MainWindow()
    window.setWindowFlags(Qt.FramelessWindowHint)
    handler = MyHandler(window)
    window.rootContext().setContextProperty("handler", handler)
    #window.rootObject().findChild(QObject, 'inputName').selectAll()
    #print window.rootContext().findChild(QObject, 'winners')
    window.showFullScreen()
    # Run the main Qt loop
    sys.exit(app.exec_())
