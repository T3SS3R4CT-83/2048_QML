import QtQuick 2.12

import "../js/GameLogic.js" as GameLogic

Item {
    property int tileSize: 80
    property int tileGap: 10

    id: playground

    Rectangle {
        width: tileSize * 4 + 5 * tileGap
        height: tileSize * 4 + 5 * tileGap
        color: "#BAAEA0"
        radius: 6

        Grid {
            rows: 4
            columns: 4
            rowSpacing: tileGap
            columnSpacing: tileGap
            padding: tileGap
            anchors.fill: parent

            Repeater {
                model: 16

                Rectangle {
                    width: tileSize
                    height: tileSize
                    color: "#CCC0B4"
                    radius: 4
                }
            }
        }
    }

    Component.onCompleted: {
        GameLogic.playgroundID = playground
        GameLogic.addRandomTile()
        GameLogic.addRandomTile()
    }

    Item {
        focus: true
        Keys.onUpPressed: {
            if (GameLogic.pushTilesUP())
                addTileTimer.start()
            GameLogic.resetTiles()
        }
        Keys.onDownPressed: {
            if (GameLogic.pushTilesDOWN())
                addTileTimer.start()
            GameLogic.resetTiles()
        }
        Keys.onLeftPressed: {
            if (GameLogic.pushTilesLEFT())
                addTileTimer.start()
            GameLogic.resetTiles()
        }
        Keys.onRightPressed: {
            if (GameLogic.pushTilesRIGHT())
                addTileTimer.start()
            GameLogic.resetTiles()
        }
    }

    Timer {
        id: addTileTimer
        interval: 200
        repeat: false
        onTriggered: {
            GameLogic.addRandomTile()
        }
    }
}
