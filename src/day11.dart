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
  List<List<String>> newGrid = [];
  for (var _column in grid) newGrid.add(List.filled(_column.length, null));

  bool valueFlipped = false;
  for (int y = 0; y < grid.length; y++) {
    for (int x = 0; x < grid[y].length; x++) {
      var point = Point(x, y);
      var currentValue = grid[y][x];
      var nextValue = rules.fold<String>(
          currentValue,
          (acc, rule) =>
              (acc == currentValue) ? rule.processSpace(point, grid) : acc);
      newGrid[y][x] = nextValue;
      if (!valueFlipped) valueFlipped = currentValue != nextValue;
    }
  }

  if (valueFlipped) {
    log("iteration ${iteration} => ${iteration + 1}");
    for (var column = 0; column < grid.length; column++) {
      log("${grid[column]} => ${newGrid[column]}");
    }
    return part1(newGrid, iteration: iteration + 1, rules: rules);
  }

  return newGrid.fold<int>(
      0,
      (acc, rows) =>
          acc + rows.fold<int>(0, (a, seat) => seat == "#" ? a + 1 : a));
}

Processor day11() {
  var output = Processor();

  List<List<String>> lines = [];

  output.callback = (line) => lines.add(line.split(""));

  output.pt1 = () => part1([...lines],
      iteration: 0, rules: [EmptySeatRulePt1(), OccupiedSeatRulePt1()]);

  output.pt2 = () => part1([...lines],
      iteration: 0, rules: [EmptySeatRulePt2(), OccupiedSeatRulePt2()]);

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

class EmptySeatRulePt1 with RuleProcessor {
  @override
  String processSpace(Point<num> coord, List<List<String>> grid) =>
      (grid[coord.y][coord.x] == "L" &&
              adjacentTo(coord, grid)
                      .where((a) => grid[a.y][a.x] == "#")
                      .length ==
                  0)
          ? "#"
          : grid[coord.y][coord.x];
}


class EmptySeatRulePt2 with RuleProcessor {
  @override
  String processSpace(Point<num> coord, List<List<String>> grid) {
    var current = grid[coord.y][coord.x];
    if (current != 'L') return current;
    return lineOfSightVectors.fold(0, (acc, vector) {
              var lastUsed = Point(coord.x, coord.y);
              for (int i = 0; i < grid.length + 1; i++){
                lastUsed = Point(lastUsed.x + vector.x, lastUsed.y + vector.y);
                if (lastUsed.x >= grid[0].length || lastUsed.x < 0) return acc;
                if (lastUsed.y >= grid.length || lastUsed.y < 0) return acc;
                if (grid[lastUsed.y][lastUsed.x] == "#") return acc +1;
                if (grid[lastUsed.y][lastUsed.x] == "L") return acc;
              }
              return acc;
            }) == 0 ? "#" : "L";
  }
}

class OccupiedSeatRulePt1 with RuleProcessor {
  @override
  String processSpace(Point<num> coord, List<List<String>> grid) =>
      (grid[coord.y][coord.x] == "#" &&
              adjacentTo(coord, grid)
                      .where((a) => grid[a.y][a.x] == "#")
                      .length >=
                  4)
          ? "L"
          : grid[coord.y][coord.x];
}

class OccupiedSeatRulePt2 with RuleProcessor {
  @override
  String processSpace(Point<num> coord, List<List<String>> grid) {
    var current = grid[coord.y][coord.x];
    if (current != '#') return current;
    return lineOfSightVectors.fold(0, (acc, vector) {
      var lastUsed = Point(coord.x, coord.y);
      for (int i = 0; i < grid.length + 1; i++){
        lastUsed = Point(lastUsed.x + vector.x, lastUsed.y + vector.y);
        if (lastUsed.x >= grid[0].length || lastUsed.x < 0) return acc;
        if (lastUsed.y >= grid.length || lastUsed.y < 0) return acc;
        if (grid[lastUsed.y][lastUsed.x] == "#") return acc +1;
        if (grid[lastUsed.y][lastUsed.x] == "L") return acc;
      }
      return acc;
    }) >=
        5
        ? "L"
        : "#";
  }
}

List<Point> adjacentTo(Point source, List<List<String>> grid) {
  int maxX = grid[source.y].length - 1;
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
      if (source.x == row && source.y == column) return acc;
      if (row >= 0 && column >= 0 && row <= maxX && column <= maxY)
        acc.add(Point(row, column));
    });
    return acc;
  });
}

void log(dynamic any) {
  if (false) print(any);
}

const lineOfSightVectors = [
  Point(-1,-1), // NW
  Point(0, -1), // N
  Point(1, -1), // NE
  Point(-1, 0), // W
  Point(1, 0), // E
  Point(-1, 1), // SW
  Point(0, 1), // S
  Point(1, 1), // SE
];
