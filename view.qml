import QtQuick 1.0

Rectangle {
    width: 800
    height: 600
    color: "white"
    
    Rectangle {
	anchors.centerIn: parent
	objectName: "badge"
	id: badge
	width: 720
	height: 420

	Rectangle {
	    anchors.centerIn: parent
	    border.width: 4
	    border.color: "black"
	    radius: 20
	    width: 700
	    height: 400
	    id: nameBadge
	    
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
		text: "#pam7"
		anchors.baseline: parent.bottom
		anchors.baselineOffset: -30
		anchors.right: parent.right
		anchors.rightMargin: 30
		font.family: "Lato"
		font.weight: Font.Normal
		font.pixelSize: 60
	    }

	    Text {
		text: "Los #2783"
		anchors.right: parent.right
		anchors.rightMargin: -40
		anchors.verticalCenter: parent.verticalCenter
		rotation: -90
		font.family: "monospace"
		font.weight: Font.Normal
		font.pixelSize: 20
		objectName: "textLos"
		visible: false
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
	anchors.right: badge.right
	anchors.top: badge.bottom
	anchors.topMargin: 40
	width: 100
	height: 30
	Text {
	    anchors.centerIn: parent
	    text: "Weiter >>"
	}
	border.width: 1
	border.color: "#999"
	MouseArea {
	    anchors.fill: parent
	    onClicked: {
		handler.run()
	    }
	}
    }
    
}