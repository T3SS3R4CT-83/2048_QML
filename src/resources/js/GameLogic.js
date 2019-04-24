.pragma library

var colors = {
    2:      "#EEE4DA",
    4:      "#EAE0C7",
    8:      "#F0B277",
    16:     "#EB8E53",
    32:     "#F57C5F",
    64:     "#E55936",
    128:    "#F2D764",
    256:    "#F7D067",
    512:    "#E3C028",
    1014:   "#FFFFFF",
    2048:   "#F9C62D",
    4096:   "#F86474",
    8192:   "#F04A60",
    16384:  "#EB423F",
    32768:  "#6EB7DA",
    65536:  "#5EA2E3",
    131072: "#007EC1",
}

var playground = [
    [null, null, null, null],
    [null, null, null, null],
    [null, null, null, null],
    [null, null, null, null]
];

var score = 0;
var running = true;
var playgroundID;

//var tileComponent = Qt.createComponent("qrc:/qml/Tile.qml");
var tileComponent = Qt.createComponent("../js/Tile.qml");
var signalSender = Qt.createQmlObject(
            'import QtQuick 2.0;'
            + 'QtObject {'
            + 'signal scoreUpdated(int value);'
            + 'signal gameOver();'
            + '}', Qt.application, 'signalSender');



function availableCells()
{
    var cells = [];

    for (let y=0; y<4; ++y) {
        for (let x=0; x<4; ++x) {
            if (playground[y][x] === null) {
                cells.push({x: x, y: y});
            }
        }
    }

    return cells;
}

function hasEmptyCells()
{
    return !!availableCells().length;
}

function getRandomEmptyCell()
{
    let cells = availableCells();

    if (cells.length) {
        return cells[Math.floor(Math.random() * cells.length)];
    } else {
        return null;
    }
}

function canMove()
{
    for (let x=0; x<=3; ++x) {
        for (let y=0; y<=3; ++y) {
            if (!playground[y][x]) return true;
            if (testCellValue(x+1, y, playground[y][x].value)) return true;
            if (testCellValue(x-1, y, playground[y][x].value)) return true;
            if (testCellValue(x, y+1, playground[y][x].value)) return true;
            if (testCellValue(x, y-1, playground[y][x].value)) return true;
        }
    }

    return false;
}

function addRandomTile()
{
    if (hasEmptyCells()) {
        let value = Math.random() < 0.9 ? 2 : 4;
        let cell = getRandomEmptyCell();
        let obj = tileComponent.createObject(
                        playgroundID,
                        { coord_X: cell.x, coord_Y: cell.y, value: value });
        playground[cell.y][cell.x] = obj;
    }

    if (!canMove()) {
        running = false;
        signalSender.gameOver();
    }
}

function resetTiles()
{
    for (let x=3; x>=0; --x) {
        for (let y=0; y<4; ++y) {
            let tile = playground[y][x];
            if (tile) {
                tile.blocked = false;
            }
        }
    }
}

function pushTilesUP()
{
    var isPushed = false;

    for (var y=1; y<=3; ++y) {
        for (var x=0; x<=3; ++x) {
            var tile = playground[y][x];
            if (tile) {
                for (var i=tile.coord_Y-1; i>=0; --i) {
                    var target = playground[i][x];
                    if (target) {
                        if (!target.blocked && target.value === tile.value) {
                            target.merging();
                            target.blocked = true;
                            tile.mergingInto(x, i);
                            playground[y][x] = null;
                            isPushed = true;
                            score += target.value;
                            signalSender.scoreUpdated(score);
                            break;
                        } else {
                            if (i + 1 !== y) {
                                playground[y][x] = null;
                                playground[i+1][x] = tile;
                                tile.coord_Y = i + 1;
                                isPushed = true;
                            }
                            break;
                        }
                    } else if (i === 0) {
                        playground[y][x] = null;
                        playground[i][x] = tile;
                        tile.coord_Y = i;
                        isPushed = true;
                        break;
                    }
                }
            }
        }
    }

    return isPushed;
}

function pushTilesLEFT()
{
    var isPushed = false;

    for (var x=1; x<4; ++x) {
        for (var y=0; y<4; ++y) {
            var tile = playground[y][x];
            if (tile) {
                for (var i=tile.coord_X-1; i>=0; --i) {
                    var target = playground[y][i];
                    if (target) {
                        if (!target.blocked && target.value === tile.value) {
                            target.merging();
                            target.blocked = true;
                            tile.mergingInto(i, y);
                            playground[y][x] = null;
                            isPushed = true;
                            score += target.value;
                            signalSender.scoreUpdated(score);
                            break;
                        } else {
                            if (i + 1 !== x) {
                                playground[y][x] = null;
                                playground[y][i+1] = tile;
                                tile.coord_X = i + 1;
                                isPushed = true;
                            }
                            break;
                        }
                    } else if (i === 0) {
                        playground[y][x] = null;
                        playground[y][i] = tile;
                        tile.coord_X = i;
                        isPushed = true;
                        break;
                    }
                }
            }
        }
    }

    return isPushed;
}

function pushTilesDOWN()
{
    var isPushed = false;

    for (var y=2; y>=0; --y) {
        for (var x=0; x<4; ++x) {
            var tile = playground[y][x];
            if (tile) {
                for (var i=tile.coord_Y+1; i<=3; ++i) {
                    var target = playground[i][x];
                    if (target) {
                        if (!target.blocked && target.value === tile.value) {
                            target.merging();
                            target.blocked = true;
                            tile.mergingInto(x, i);
                            playground[y][x] = null;
                            isPushed = true;
                            score += target.value;
                            signalSender.scoreUpdated(score);
                            break;
                        } else {
                            if (i - 1 !== y) {
                                playground[y][x] = null;
                                playground[i-1][x] = tile;
                                tile.coord_Y = i - 1;
                                isPushed = true;
                            }
                            break;
                        }
                    } else if (i === 3) {
                        playground[y][x] = null;
                        playground[i][x] = tile;
                        tile.coord_Y = i;
                        isPushed = true;
                        break;
                    }
                }
            }
        }
    }

    return isPushed;
}

function pushTilesRIGHT()
{
    var isPushed = false;

    for (var x=2; x>=0; --x) {
        for (var y=0; y<4; ++y) {
            var tile = playground[y][x];
            if (tile) {
                for (var i=tile.coord_X+1; i<=3; ++i) {
                    var target = playground[y][i];
                    if (target) {
                        if (!target.blocked && target.value === tile.value) {
                            target.merging();
                            target.blocked = true;
                            tile.mergingInto(i, y);
                            playground[y][x] = null;
                            isPushed = true;
                            score += target.value;
                            signalSender.scoreUpdated(score);
                            break;
                        } else {
                            if (i - 1 !== x) {
                                playground[y][x] = null;
                                playground[y][i-1] = tile;
                                tile.coord_X = i - 1;
                                isPushed = true;
                            }
                            break;
                        }
                    } else if (i === 3) {
                        playground[y][x] = null;
                        playground[y][i] = tile;
                        tile.coord_X = i;
                        isPushed = true;
                        break;
                    }
                }
            }
        }
    }

    return isPushed;
}

function testCellValue(x, y, val)
{
    if (x < 0 || x > 3 || y < 0 || y > 3 || !playground[y][x]) return false;
    return playground[y][x].value === val;
}

function startNewGame()
{
    for (let x=0; x<=3; ++x) {
        for (let y=0; y<=3; ++y) {
            if (playground[y][x]) {
                playground[y][x].destroy();
                playground[y][x] = null;
            }
        }
    }

    running = true;
    score = 0;
    signalSender.scoreUpdated(score);

    addRandomTile();
    addRandomTile();
}
