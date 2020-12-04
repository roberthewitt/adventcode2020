import 'dart:math';

import '../utils.dart';

const tree = "#";

class DataGrid {
  int _hits = 0;
  Point _location = new Point(0, 0);
  List<List<String>> _column = [];

  void reset() {
    _hits = 0;
    _location = new Point(0, 0);
  }

  Point get location => _location;

  int get hits => _hits;

  bool canMove(Point by) {
    return (_location.y + by.y) < _column.length;
  }

  void move(Point by) {
    var newX = _location.x + by.x;
    var sizeOfXGrid = _column[0].length;
    _location = new Point(newX % sizeOfXGrid, _location.y + by.y);
    if (_column[_location.y][_location.x] == tree) _hits++;
  }

  void addRow(List<String> row) {
    _column.add(row);
  }
}

void main() {
  var grid = new DataGrid();
  readFileByLine("data/day3.txt", (line) {
    grid.addRow(line.split(""));
  }, onComplete: () {
    List<Point> moves = [
      Point(1, 1),
      Point(3, 1),
      Point(5, 1),
      Point(7, 1),
      Point(1, 2),
    ];

    var result = moves.map((move) {
      grid.reset();
      while (grid.canMove(move)) {
        grid.move(move);
      }
      print('trees hit using $move = ${grid.hits}');
      return grid.hits;
    }).reduce((a, b) => a * b);

    print('trees multiplied: $result');
  });
}
