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
       				if (event.key == Qt.Key_Return || event.key == Qt.Key_Tab) {
				   inputTwitter.focus = true;
				   inputTwitter.select(1,8);
            			   event.accepted = true;
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
		text: "#pam9"
		anchors.baseline: parent.bottom
		anchors.baselineOffset: -30
		anchors.right: parent.right
		anchors.rightMargin: 30
		font.family: "Lato"
		font.weight: Font.Normal
		font.pixelSize: 60
	    }

	    Text {
		text: "Los #XXXX"
		anchors.right: parent.right
		anchors.rightMargin: -40
		anchors.verticalCenter: parent.verticalCenter
		rotation: -90
		font.family: "monospace"
		font.weight: Font.Normal
		font.pixelSize: 20
		objectName: "textLos"
		visible: x1.visible
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

    Rectangle {
	anchors.left: badge.left
	anchors.leftMargin: 10
	anchors.top: badge.bottom
	anchors.topMargin: 40
	width: 30
	height: 30
	border.width: 4
	border.color: "#000"
	id: checkbox
	opacity: nameBadge.opacity

	Text {
	    text: "X"
	    font.family: "Courier"
	    font.pixelSize: 25
	    font.bold: true
	    anchors.centerIn: parent
	    id: x1
	    objectName: "checkboxSelected"
	}

	MouseArea {
	    anchors.fill: parent
	    onClicked: {
		x1.visible = !x1.visible;
	    }
	}



	Text {
	    anchors.left: checkbox.right
	    anchors.leftMargin: 15
	    anchors.baseline: checkbox.bottom
	    anchors.baselineOffset: -7
	    font.family: "Lato"
	    font.pixelSize: 25
	    font.weight: Font.Normal
	    text: "An der Verlosung teilnehmen"
	    id: checkboxText1
	}

	Text {
	    anchors.left: checkboxText1.left
	    anchors.top: checkboxText1.bottom
	    anchors.topMargin: 5
	    font.family: "Lato"
	    font.pixelSize: 20
	    font.weight: Font.Normal
	    text: "Am Ende der Veranstaltung werden unter allen Anwesenden Sachpreise verlost (Bücher, Gadgets, etc.). Dein Namensschild ist das Los."
	    wrapMode: Text.WordWrap
	    width: 450
	}

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