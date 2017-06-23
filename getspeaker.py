#!/usr/bin/env python3
# -'''- coding: utf-8 -'''-
 
import sys
import subprocess
from PySide.QtCore import *
from PySide.QtGui import *
from PySide.QtDeclarative import *
import PIL
import PIL.Image
import random 
from time import sleep
import os


os.chdir(os.path.dirname(os.path.realpath(__file__)))


names = ["Alain Mauer", "alp", "Andre Simon", "AndreasZ", "Boris Ruth", "Christian Immler", "Claus Brell", "dewomser", "Florian Wesch", "Friedemann Metzger", "Gerhard Hepp", "Gunter Pietzsch", "Hans de Jong", "Horatius Stream", "Malte Schilling", "Marco Mueller", "Martina Gnaegy", "Michael Stapelberg", "Nico Maas", "Reiner Haffner", "Rainer Wieland", "Tobias Blum", "Tobias Wagner"]
random.shuffle(names)

class MyHandler(QObject):
    

    def __init__(self, window, app, *args, **kwargs):
        QObject.__init__(self, *args, **kwargs)
        self.window = window
        self.app = app

    @Slot()
    def shuffle(self):
        if len(names) == 0:
            name = "(Ende!)"
        else:
            name = names.pop()
        
        window.rootContext().setContextProperty("latestWinnerName", name);

    


# Our main window
class MainWindow(QDeclarativeView):
 
    def __init__(self, parent=None):
        super(MainWindow, self).__init__(parent)
        self.setWindowTitle("Main Window")
        # Renders 'view.qml'
        self.setSource(QUrl.fromLocalFile('getspeaker.qml'))
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
