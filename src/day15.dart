import '../utils.dart';

class Processor {
  Function(String) callback;
  int Function() pt1;
  int Function() pt2;
}

Processor day15() {
  var output = Processor();

  List<String> input = [];

  output.callback = input.add;

  output.pt1 = () {
    List<int> valuesSpoken = [];
    var initialValues = input[0].split(",");
    for (var initial in initialValues) valuesSpoken.add(int.parse(initial));

    while (valuesSpoken.length != 2020) valuesSpoken = calculateNext(valuesSpoken);

    return valuesSpoken.last;
  };

  output.pt2 = () {
    return 0;
  };

  return output;
}

List<int> calculateNext(List<int> current) {
  var target = current.last;
  if (current.where((e) => e == target).length == 1) return [...current, 0];

  for (int i = current.length - 2; i >= 0; i--) {
    if (current[i] == target) {
      return [...current, current.length -1 - i];
    }
  }
}

main() {
  var day = 15;
  var testData = "data/day${day}_testData.txt";
  var realData = "data/day${day}.txt";

  var processor_testData = day15();
  readFileByLine(testData, processor_testData.callback, solve: () {
    print('<< day $day pt 1 >> ${processor_testData.pt1()}');
  }, onComplete: () {
    var processor_pt1 = day15();
    readFileByLine(realData, processor_pt1.callback, solve: () {
      print('<< day $day pt 1 >> ${processor_pt1.pt1()}');
    }, onComplete: () {
      var processor_pt2 = day15();
      readFileByLine(realData, processor_pt2.callback, solve: () {
        print('<< day $day pt 2 >> ${processor_pt2.pt2()}');
      });
    });
  });
}

void log(dynamic any) {
  if (false) print(any);
}
