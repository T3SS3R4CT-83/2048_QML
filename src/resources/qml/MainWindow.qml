import QtQuick 2.12
import QtQuick.Window 2.12

import "../js/GameLogic.js" as GameLogic

Window {

    title: "2048"
    width: 390
    height: 480
    minimumWidth: 390
    minimumHeight: 480
    maximumWidth: 390
    maximumHeight: 480
    visible: true

    Rectangle {
        id: btnNewGame
        x: 10
        y: 10
        width: (parent.width - 30) / 2
        height: 80
        color: "#BAAEA0"
        radius: 6

        Text {
            text: qsTr("NEW GAME")
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.bold: true
            font.pixelSize: 26
            color: "#EFF9F8"
        }

        MouseArea {
            anchors.fill: parent

            onClicked: {
                if (GameLogic.running)
                    GameLogic.startNewGame()
            }
        }
    }

    Rectangle {
        id: scoreBoard
        x: (parent.width - 30) / 2 + 20
        y: 10
        width: (parent.width - 30) / 2
        height: 80
        color: "#BAAEA0"
        radius: 6

        property int score: 0

        function onScoreUpdated(value) {
            score = value
        }

        Text {
            text: qsTr("SCORE")
            x: 0
            y: 10
            width: parent.width
            height: 20
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.bold: true
            font.pixelSize: 20
            color: "#DCD0BE"
        }

        Text {
            text: scoreBoard.score
            y: 10
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.bold: true
            font.pixelSize: 36
            color: "#EFF9F8"
        }

        Component.onCompleted: {
            GameLogic.signalSender.scoreUpdated.connect(onScoreUpdated)
        }
    }

    Playground {
        x: 10
        y: 100
    }

    Rectangle {
        id: resultOverlay
        anchors.fill: parent

        Text {
            text: qsTr("GAME OVER")
            font.bold: true
            font.pixelSize: 40
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: parent.height / 4 - 40
            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            id: finalScore
            font.bold: true
            font.pixelSize: 80
            anchors.left: parent.left
            anchors.right: parent.right
            y: parent.height / 2 - 80
            horizontalAlignment: Text.AlignHCenter
        }

        Rectangle {
            id: btnRestart
            x: parent.width * 0.2
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height / 4
            width: parent.width * 0.6
            height: 60
            color: "#cd5555"
            radius: 6

            Text {
                text: qsTr("RESTART GAME")
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "#FFFFFF"
                font.bold: true
                font.pixelSize: 24
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    stateGroup.state = "GAME_RUNNING"
                    GameLogic.startNewGame()
                }
            }
        }
    }

    StateGroup {
        id: stateGroup
        state: "GAME_RUNNING"
        states: [
            State {
                name: "GAME_RUNNING"
                PropertyChanges {
                    target: resultOverlay
                    opacity: 0
                }
            },
            State {
                name: "GAME_OVER"
                PropertyChanges {
                    target: resultOverlay
                    opacity: 0.8
                }
            }
        ]
        transitions: Transition {
            from: "GAME_RUNNING"
            to: "GAME_OVER"
            reversible: true

            PropertyAnimation {
                target: resultOverlay
                property: "opacity"
                duration: 500
            }
        }

        function endGame() {
            finalScore.text = GameLogic.score
            stateGroup.state = "GAME_OVER"
        }

        Component.onCompleted: {
            GameLogic.signalSender.gameOver.connect(endGame)
        }
    }
}
