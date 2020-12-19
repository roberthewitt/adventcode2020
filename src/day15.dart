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

  output.pt1 = () => calculate(input[0], 2020);

  output.pt2 = () => calculate(input[0], 30000000);

  return output;
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

int calculate(String initial, int target) {
  List<int> initialValues = initial.split(",").map((e) => int.parse(e)).toList();
  int turn = 0;

  Map<int, int> lastSpokenAt = {};
  Map<int, int> spokenCount = {};

  for (int i = 0; i < initialValues.length; i++) {
    turn++;

    var value = initialValues[i];
    if (i != initialValues.length - 1) lastSpokenAt[value] = turn;
    if (!spokenCount.containsKey(value)) spokenCount[value] = 0;
    spokenCount[value] = 1 + spokenCount[value];
  }

  turn++;

  int lastSpoken = initialValues.last;
  for (; turn != (target + 1); turn++) {
    int current = 0;
    if ((spokenCount[lastSpoken] ?? 0) > 1) {
      current = turn - 1 - lastSpokenAt[lastSpoken];
    }

    lastSpokenAt[lastSpoken] = turn - 1;
    spokenCount[current] = (spokenCount[current] ?? 0) + 1;
    lastSpoken = current;
  }

  return lastSpoken;
}

void log(dynamic any) {
  if (false) print(any);
}
