import 'dart:math';

import '../utils.dart';

class Processor {
  Function(String) callback;
  int Function() pt1;
  int Function() pt2;
}

Processor day10() {
  var output = Processor();

  List<int> lines = [];

  output.callback = (input) => lines.add(int.parse(input));

  List<int> part1(List<int> input) {
    input.sort();
    input.add(input.last + 3);
    int currentVoltage = 0;
    return input.fold(List.filled(3, 0), (acc, value) {
      var delta = value - currentVoltage;
      if (delta == 1) acc[0] = acc[0] + 1;
      if (delta == 2) acc[1] = acc[1] + 1;
      if (delta == 3) acc[2] = acc[2] + 1;
      currentVoltage = value;
      return acc;
    });
  }

  output.pt1 = () {
    var result = part1([...lines]);
    print(result);
    return result[0] * result[2];
  };

  List<int> part2(List<int> input) {
    input.sort();
    input.add(input.last + 3);
    int currentVoltage = 0;
    List<int> result = List.filled(10, 0);
    // number of 1's contiguous
    input.fold(0, (acc, value) {
      var delta = value - currentVoltage;
      currentVoltage = value;

      if (delta == 1) acc = acc + 1;
      if (delta == 2) throw StateError("cry, delta 2");
      if (delta == 3) {
        acc = acc - 1;
        if (acc > 0) {
          result[acc] = result[acc] + 1;
        }
        acc = 0;
      }
      return acc;
    });

    return result;
  }

  output.pt2 = () {
    var result = part2([...lines]);
    print(result);
    var ones = pow(2, result[1]);
    var twos = pow(4, result[2]);
    var threes = pow(7, result[3]);
    print("by 1s = 2^1^(1s) = 2^(${result[1]}) = ${ones}");
    print("by 2s = 2^2^(2s) = 4^(${result[2]}) = ${twos}");
    print("by 3s = 7^(3s)   = 7^(${result[3]}) = ${threes}");

    return ones * twos * threes;
  };

  return output;
}

main() {
  var day = 10;
  var testData = "data/day${day}_testData.txt";
  var realData = "data/day${day}.txt";

  var processor_testData = day10();
  readFileByLine(testData, processor_testData.callback, solve: () {
    print('<< day $day pt 1 >> ${processor_testData.pt1()}');
  }, onComplete: () {
    var processor_pt1 = day10();
    readFileByLine(realData, processor_pt1.callback, solve: () {
      print('<< day $day pt 1 >> ${processor_pt1.pt1()}');
    }, onComplete: () {
      var processor_pt2 = day10();
      readFileByLine(realData, processor_pt2.callback, solve: () {
        print('<< day $day pt 2 >> ${processor_pt2.pt2()}');
      });
    });
  });
}
