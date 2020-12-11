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

class EmptySeatRule with RuleProcessor {
  @override
  String processSpace(Point<num> coord, List<List<String>> grid) {
    var seat = grid[coord.y][coord.x];



    return seat;
  }

}

int part1 (List<List<String>> grid, {int iteration: 0}) {
  for (int i = 0; i < grid.length; i++){
    var row = grid[i];
    for(int j = 0; j < row.length ; j++) {
      var point = Point(i,j);

    }
  }

  print("after iteration $iteration");
  grid.forEach(print);
  return 0;
}

Processor day11() {
  var output = Processor();

  List<List<String>> lines = [];

  output.callback = (line) => lines.add(line.split(""));

  output.pt1 = () => part1([...lines]);

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
