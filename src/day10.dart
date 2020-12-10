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
    return input.fold(List.filled(2, 0), (acc, value) {
      var delta = value - currentVoltage;
      if (delta == 1) acc[0] = acc[0] + 1;
      if (delta == 3) acc[1] = acc[1] + 1;
      currentVoltage = value;
      return acc;
    });
  }

  output.pt1 = () {
    var result = part1([...lines]);
    print(result);
    return result[0] * result[1];
  };

  output.pt2 = () => 0;

  return output;
}

main() {
  var day = 10;
  var realData = "data/day${day}.txt";
  var testData = "data/day${day}_testData.txt";

  var processor_testData = day10();
  readFileByLine(testData, processor_testData.callback, onComplete: () {
    print('<< test data result: ${processor_testData.pt1()}');

    var processor_pt1 = day10();
    readFileByLine(realData, processor_pt1.callback, onComplete: () {
      print('<< part 1 >> result: ${processor_pt1.pt1()}');

      var processor_pt2 = day10();
      readFileByLine(realData, processor_pt2.callback, onComplete: () {
        print('<< part 2 >> result: ${processor_pt2.pt2()}');
      });
    });
  });
}
