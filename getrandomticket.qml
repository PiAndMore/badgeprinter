import QtQuick 1.0


Rectangle {

    Component {
	id: winner
	Item {
	    property variant text: "";
	    height: 40
	    width: 512
	    Text {
		text: parent.text;
		font.pixelSize: 40
		id: txt
		horizontalAlignment: Text.AlignHCenter
		width: parent.width
	    }
	    MouseArea {
		anchors.fill: parent
		onClicked: {
		    txt.font.strikeout = !txt.font.strikeout;
		    mouse.accepted = true;
		}
	    }
	}
    }
    
    width: 1024
    height: 768
    color: "white"
    id: main

    
    Text {
	text: "Gewinner:"
	font.family: "Lato"
	font.pixelSize: 60
	font.weight: Font.Normal
	anchors.horizontalCenter: parent.horizontalCenter
	anchors.top: parent.top
	anchors.topMargin: 30
    }



    Image {
	source: "piandmore-small.png"
	anchors.left: parent.left
	anchors.leftMargin: 20
	anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
	
	width: 150
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
    }


    
    
    PropertyAnimation {
	id: animateWinnerOn
	//objectName: "animateWinnerOn"
	target: currentWinner
	properties: "anchors.bottomMargin"
	from: -200
	to: -15
	duration: 200
	onRunningChanged: {
	    if (! running) {
		winner.createObject(winners, {text: currentWinner.text});
	    }

	}
    }
    
    PropertyAnimation {
	id: animateWinnerOff
	//objectName: "animateWinnerOff"
	target: currentWinner
	properties: "opacity"
	from: 1
	to: 0
	duration: 200
    }

    Rectangle {
	id: currentWinner
	width: parent.width
	height: 210
	anchors.horizontalCenter: parent.horizontalCenter
	anchors.bottom: parent.bottom
	anchors.bottomMargin: -height
	border.width: 5
	border.color: "black"
	radius: 10
	color: "#0d0";
	property variant text: ""
	property variant number: ""
	Text {
	    anchors.horizontalCenter: parent.horizontalCenter
	    anchors.bottom: parent.parent.bottom
	    text: "#" + parent.number + ": " + parent.text
	    font.pixelSize: 150
	    width: parent.width
	    horizontalAlignment: Text.AlignHCenter
	}
    }

    MouseArea {
	anchors.fill: parent
	onClicked: {
	    //handler.test();
	    //winners.children[0].children[0].text = test;
	    handler.shuffle();
	    var w = "" + latestWinnerName;
	    currentWinner.text = w;
	    currentWinner.number = latestWinnerTicket
	    animateWinnerOn.start();
	}
    }
    
    Grid {
	anchors.horizontalCenter: parent.horizontalCenter
	anchors.top: parent.top
	anchors.topMargin: 120
	id: winners
	spacing: 10
	columns: 2
    }

    

    

}
