import QtQuick 2.12

import "GameLogic.js" as GameLogic

Rectangle {
    id: tile
    x: gap + (size + gap) * coord_X
    y: gap + (size + gap) * coord_Y
    width: size
    height: size
    radius: 4
    color: GameLogic.colors[value]
    transformOrigin: Item.Center
    scale: 0

    property bool blocked: false
    property int value: 2
    property int coord_X: 0
    property int coord_Y: 0
    property int gap: 10
    property int size: 80

    function merging() {
        value *= 2
        mergingTimer.start()
    }

    function mergingInto(x, y) {
        coord_X = x
        coord_Y = y
        destroyTimer.start()
    }

    Behavior on scale {
        NumberAnimation { duration: 100 }
    }

    Text {
        text: value
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.bold: true
        font.pointSize: size / (2 + (value.toString().length - 1) * 0.9)
        color: value <= 4 ? "#776D61" : "#EFF9F8"
    }

    SequentialAnimation {
        id: mergeAnim

        PauseAnimation {
            duration: 100
        }

        ParallelAnimation {

            PropertyAnimation {
                target: tile
                property: "color"
                from: GameLogic.colors[value / 2]
                to: GameLogic.colors[value]
                duration: 100
            }

            SequentialAnimation {

                PropertyAnimation {
                    target: tile
                    property: "scale"
                    from: 1
                    to: 1.3
                    duration: 50
                }

                PropertyAnimation {
                    target: tile
                    property: "scale"
                    from: 1.3
                    to: 1
                    duration: 50
                }
            }
        }
    }

    Behavior on x {
        PropertyAnimation { duration: 100 }
    }

    Behavior on y {
        PropertyAnimation { duration: 100 }
    }

    Component.onCompleted: {
        tile.scale = 1
    }

    Timer {
        id: mergingTimer
        interval: 100
        repeat: false

        onTriggered: {
            mergeAnim.start()
        }
    }

    Timer {
        id: destroyTimer
        interval: 100
        repeat: false

        onTriggered: {
            parent.destroy()
        }
    }
}
