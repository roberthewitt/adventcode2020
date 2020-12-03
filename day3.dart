import 'dart:convert';
import 'dart:io';
import 'dart:math';

const tree = "#";

class DataGrid {
  int _hits = 0;
  Point _location = new Point(0, 0);
  List<List<String>> _column = [];

  get location => _location;
  get hits => _hits;

  bool canMove(Point by) {
    return (_location.y + by.y) < _column.length ;
  }

  void move(Point by) {}

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
   
    print('trees hit: ${grid.hits}');
  });
}
