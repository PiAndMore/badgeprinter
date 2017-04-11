import QtQuick 1.0

Rectangle {
    width: 800
    height: 600
    color: "white"
    
    Text {
	text: "Namensschild drucken:"
	font.family: "Lato"
	font.pixelSize: 60
	font.weight: Font.Normal
	anchors.horizontalCenter: parent.horizontalCenter
	anchors.bottom: badge.top
	anchors.bottomMargin: 60
    }

    Rectangle {
	anchors.centerIn: parent
	objectName: "badge"
	id: badge
	width: 720
	height: 420

	Text {
	    text: "Bitte warten..."
	    font.family: "Lato"
	    font.pixelSize: 50
	    anchors.centerIn: parent
	    visible: true
	    objectName: "waitText"
	}

	Rectangle {
	    anchors.centerIn: parent
	    border.width: 4
	    border.color: "black"
	    color: "white";
	    radius: 20
	    width: 700
	    height: 400
	    id: nameBadge
	    objectName: "nameBadge"
	    
	    TextInput {
		text: "Vorname"
		font.family: "Lato"
		font.weight: Font.Normal
		font.pixelSize: Math.min(240 * (600/invisibleText.width), 240)
		id: inputName
		anchors.left: parent.left
		anchors.leftMargin: 30
		anchors.baseline: inputTwitter.top
		anchors.baselineOffset: -(30 + font.pixelSize)
		selectByMouse: true
		objectName: "inputName"
		focus: true
		Keys.onPressed: {
			if (event.key == Qt.Key_Escape) {
			   inputName.text = "Vorname";
			   inputTwitter.text = "@twitter";
			   inputName.focus = true;
			   inputName.selectAll();
			}			   
			if (event.key == Qt.Key_Tab || event.key == Qt.Key_Return) {
			inputTwitter.select(1,8);
			inputTwitter.focus = true;
			}

		}
	    }		   	   
	    
	    TextInput {
		text: "@twitter"
		anchors.baseline: parent.bottom
		anchors.baselineOffset: -(30 + font.pixelSize)
		anchors.left: parent.left
		anchors.leftMargin: 30
		font.family: "Lato"
		font.weight: Font.Normal
		font.pixelSize: 60
		selectByMouse: true
		id: inputTwitter
		objectName: "inputTwitter"
		color: (text == "@twitter") ? "#999" : "#000"
		MouseArea {
		    anchors.fill: parent
		    enabled: inputTwitter.focus == false && inputTwitter.text == "@twitter" 
		    onClicked: {
			inputTwitter.select(1,8);
			inputTwitter.focus = true;
		    }
		}
		Keys.onPressed: {
			if (event.key == Qt.Key_Escape) {
			   inputName.text = "Vorname";
			   inputTwitter.text = "@twitter";
			   inputName.focus = true;
			   inputName.selectAll();
			}			   
       				if (event.key == Qt.Key_Return) {
						    handler.run();
				}
		}
	    }

	    Image {
		source: "piandmore-small.png"
		anchors.right: parent.right
		anchors.rightMargin: 20
		anchors.top: parent.top
		anchors.topMargin: 20
		height: 70
		fillMode: Image.PreserveAspectFit
		smooth: true
	    }
	    
	    
	    Text {
		text: "#pam10"
		anchors.baseline: parent.bottom
		anchors.baselineOffset: -34
		anchors.right: parent.right
		anchors.rightMargin: 30
		font.family: "Lato"
		font.weight: Font.Normal
		font.pixelSize: 60
		visible: (inputTwitter.text.length < 11) 
	    }

	    Text {
		text: "Los #XXXX"
		anchors.right: parent.right
		anchors.rightMargin: -70
		anchors.verticalCenter: parent.verticalCenter
		rotation: -90
		font.family: "monospace"
		font.weight: Font.Normal
		font.pixelSize: 40
		objectName: "textLos"
		//visible: x1.visible
		id: textLos
	    }

	}

	Text {
	    text: inputName.text
	    font.family: "Lato"
	    font.pixelSize: 240
	    id: invisibleText
	    visible: false
	}



	
    }



	Text {
	    anchors.left: badge.left
	    anchors.leftMargin: 10
	    anchors.top: badge.bottom
            anchors.topMargin: 40
            opacity: nameBadge.opacity
	    font.family: "Lato"
	    font.pixelSize: 20
	    font.weight: Font.Normal
	    text: "Am Ende der Veranstaltung werden unter allen Anwesenden Sachpreise verlost (Bücher, Gadgets, etc.). Dein Namensschild ist das Los. Der Rechtsweg ist ausgeschlossen."
	    wrapMode: Text.WordWrap
	    width: 450
	}

    
    

    
    Rectangle {
	anchors.right: badge.right
	anchors.top: badge.bottom
	anchors.topMargin: 40
	width: 130
	height: 40
	color: "#e9e9e9"
	opacity: nameBadge.opacity
	Text {
	    font.family: "Lato"
	    font.pixelSize: 20
	    font.weight: Font.Normal
	    anchors.centerIn: parent
	    color: (inputName.text == "Vorname" || inputName.text.length < 2) ? "#999" : "#000"
	    text: "Drucken >>"
	}

	Text {
	    font.family: "Lato"
	    font.pixelSize: 16
	    font.weight: Font.Normal
	    anchors.top: parent.bottom
	    anchors.topMargin: 10
	    anchors.left: parent.left
	    color:  "#000"
	    text: "Namensschild bitte nicht auf empfindliche Stoffe kleben."
	}


	MouseArea {
	    anchors.fill: parent
	    onClicked: {
		if (inputName.text == "Vorname" || inputName.text.length < 2) {
		} else {
		    enabled = false;
		    handler.run();
		}
	    }
	    objectName: "printButtonArea"
	}
    }
    

    PropertyAnimation {
	id: animateNameBadgeOff
	objectName: "animateNameBadgeOff"
	target: nameBadge
	properties: "opacity"
	to: 0
	duration: 200
    }

    PropertyAnimation {
	id: animateNameBadgeOn
	objectName: "animateNameBadgeOn"
	target: nameBadge
	properties: "opacity"
	to: 1
	duration: 200
    }
}
