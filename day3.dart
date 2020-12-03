import 'dart:convert';
import 'dart:io';
import 'dart:math';

const tree = "#";

class DataGrid {
  int _hits = 0;
  Point _location = new Point(0, 0);
  List<List<String>> _column = [];

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
  new File("inputData_day3.txt")
      .openRead()
      .map(utf8.decode)
      .transform(new LineSplitter())
      .forEach((line) {
    grid.addRow(line.split(""));
  }).whenComplete(() {
    var moveBy = Point(3,1);
    while (grid.canMove(moveBy)) {
      grid.move(moveBy);
    }
    print('trees hit: ${grid.hits}');
  });
}
