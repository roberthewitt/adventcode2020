import 'dart:math';

import '../utils.dart';

class Processor {
  Function(String) callback;
  int Function() pt1;
  int Function() pt2;
}

mixin RuleProcessor {
  String processSpace(Point coord, List<List<String>> grid);
}

int part1(List<List<String>> grid,
    {int iteration: 0, List<RuleProcessor> rules}) {
  List<List<String>> newGrid = List.filled(grid.length, List(grid[0].length));

  bool valueFlipped = false;
  for (int y = 0; y < grid.length; y++) {
    var row = grid[y];
    for (int x = 0; x < row.length; x++) {
      var point = Point(x, y);
      var currentValue = grid[y][x];
      newGrid[y][x] = rules.fold<String>(currentValue, (acc, rule) {
        return (acc == currentValue) ? rule.processSpace(point, grid) : acc;
      });
      valueFlipped = valueFlipped ? true : newGrid[y][x] != currentValue;
    }
  }

  if (valueFlipped) return part1(newGrid, iteration: iteration +1, rules: rules);

  print("finished with: $iteration");
  newGrid.forEach(print);
  return 0;
}

Processor day11() {
  var output = Processor();

  List<List<String>> lines = [];

  output.callback = (line) => lines.add(line.split(""));

  output.pt1 = () => part1([...lines], rules: [EmptySeatRule()]);

  output.pt2 = () => 0;

  return output;
}

main() {
  var day = 11;
  var testData = "data/day${day}_testData.txt";
  var realData = "data/day${day}.txt";

  var processor_testData = day11();
  readFileByLine(testData, processor_testData.callback, solve: () {
    print('<< day $day pt 1 >> ${processor_testData.pt1()}');
  }, onComplete: () {
    var processor_pt1 = day11();
    readFileByLine(realData, processor_pt1.callback, solve: () {
      print('<< day $day pt 1 >> ${processor_pt1.pt1()}');
    }, onComplete: () {
      var processor_pt2 = day11();
      readFileByLine(realData, processor_pt2.callback, solve: () {
        print('<< day $day pt 2 >> ${processor_pt2.pt2()}');
      });
    });
  });
}

class EmptySeatRule with RuleProcessor {
  @override
  String processSpace(Point<num> coord, List<List<String>> grid) {
    var seat = grid[coord.y][coord.x];
    var adjacent = adjacentSeats(coord, grid);
    if (seat == "L") {
      return adjacent.where((a) => grid[a.y][a.x] == "#").length == 0
          ? "#"
          : seat;
    }
    return seat;
  }
}

List<Point> adjacentSeats(Point source, List<List<String>> grid) {
  int maxX = grid[0].length - 1;
  int maxY = grid.length - 1;
  Map<int, List<int>> modifiers = {
    -1: [-1, 0, 1],
    0: [-1, 0, 1],
    1: [-1, 0, 1],
  };
  return modifiers.entries.fold<List<Point>>([], (acc, entry) {
    var column = source.y + entry.key;
    entry.value.forEach((rowMod) {
      var row = source.x + rowMod;
      if (row >= 0 && column >= 0 && row <= maxX && column <= maxY)
        acc.add(Point(column, row));
    });
    return acc;
  });
}
