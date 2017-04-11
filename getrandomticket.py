#!/usr/bin/env python3
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

        c = self.conn.cursor()
        c.execute(""" SELECT name, ticket FROM badges ORDER BY random()""")
        self.winners = c.fetchall()

    @Slot()
    def shuffle(self):
        name, ticket = self.winners.pop()
        
        window.rootContext().setContextProperty("latestWinnerName", name);
        window.rootContext().setContextProperty("latestWinnerTicket", ticket);

    


# Our main window
class MainWindow(QDeclarativeView):
 
    def __init__(self, parent=None):
        super(MainWindow, self).__init__(parent)
        self.setWindowTitle("Main Window")
        # Renders 'view.qml'
        self.setSource(QUrl.fromLocalFile('getrandomticket.qml'))
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
    window.showFullScreen()
    # Run the main Qt loop
    sys.exit(app.exec_())
