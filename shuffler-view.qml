import QtQuick 1.0


Rectangle {
    width: 800
    height: 600
    color: "white"
    focus: true
    Keys.onPressed: {
	if (event.key == Qt.Key_Return) {
	    handler.run(winners);
	}
    }

	    Image {
		source: "avatar.svg"
		anchors.left: parent.left
		anchors.leftMargin: 20
		anchors.top: parent.top
		anchors.topMargin: -100
		fillMode: Image.PreserveAspectFit
		smooth: true
		width: 500
	    }


    Text {
	text: "Herzlichen Glückwunsch an ..."
	font.family: "Lato"
	font.pixelSize: 60
	font.weight: Font.Normal
	anchors.horizontalCenter: parent.horizontalCenter
	anchors.top: parent.top
	anchors.topMargin: 20
	anchors.bottomMargin: 60
	visible: true
	id: gewinner
    }

    Text {
	text: "#pam9"
	font.family: "Lato"
	font.pixelSize: 170
	font.weight: Font.Normal
	anchors.right: parent.right
	anchors.bottom: parent.bottom
	anchors.bottomMargin: 20
	anchors.rightMargin: 20
	visible: true
	color: "#999"
    }


    Rectangle {
	anchors.horizontalCenter: parent.horizontalCenter
	anchors.top: gewinner.bottom
	objectName: "badge"
	id: badge
	width: 720
	height: 1020
	clip: true

	Text {
	    id: winners
	    objectName: "winners"
	    text: ""
	    font.family: "Lato"
	    font.pixelSize: 50
	    anchors.centerIn: parent
	    visible: true
	    clip: true
	    //verticalAlignment: TextInput.AlignBottom
	}
    }

}