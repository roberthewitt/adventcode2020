import 'dart:math';

import '../utils.dart';

const tree = "#";

class Processor {
  Function(String line) callback;
  int Function(Point moveBy) hits;
}

Processor newProcessor() {
  List<List<String>> column = [];

  var processor = new Processor();
  processor.callback = (line) {
    column.add(line.split(""));
  };
  processor.hits = (moveBy) {
    int hits = 0;
    Point location = new Point(0, 0);
    bool canMove(Point by) => (location.y + by.y) < column.length;
    void doMove(Point by) {
      var newX = location.x + by.x;
      var sizeOfXGrid = column[0].length;
      location = new Point(newX % sizeOfXGrid, location.y + by.y);
      if (column[location.y][location.x] == tree) hits++;
    }

    while (canMove(moveBy)) doMove(moveBy);

    return hits;
  };
  return processor;
}

void main() {
  Processor processor = newProcessor();
  readFileByLine("data/day3.txt", processor.callback, solve: () {
    var result = [
      Point(1, 1),
      Point(3, 1),
      Point(5, 1),
      Point(7, 1),
      Point(1, 2),
    ].map(processor.hits).reduce((a, b) => a * b);

    print('trees multiplied: $result');
  });
}
