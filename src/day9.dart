import '../utils.dart';
import 'day1.dart';

class Processor {
  Function(String) callback;
  int Function({int preamble}) pt1;
  List<int> Function(int searchFor) pt2;
}

Processor processor9() {
  var output = Processor();

  List<int> lines = [];
  output.callback = (str) => lines.add(int.parse(str));

  int part1({int index, int size}) {
    var window = lines.sublist(index, size + index);
    var sum = lines[index + size];
    // print("searching for sum:$sum in $window from source:$lines ");
    var result = findTupleOf(window, 2, sum, []);
    if (result.isEmpty) return sum;
    if (index + 1 + size >= lines.length) throw StateError("No match using window:${window} for sum: $sum");
    return part1(index: index + 1, size: size);
  }

  output.pt1 = ({int preamble}) => part1(index: 0, size: preamble);

  List<int> search(int sum, {int tupleSize: 2}) {
    // print("attempting search for $sum with tupleSize: $tupleSize");

    for (int i = 0; i + tupleSize < lines.length; i++) {
      var window = lines.sublist(i, tupleSize + i);

      if (window.isNotEmpty && sum == window.reduce((a, b) => a + b)) return window;
    }

    if (tupleSize == lines.length - 1) {
      throw StateError("Failed to find");
    }
    return search(sum, tupleSize: tupleSize + 1);
  }

  output.pt2 = (sum) => search(sum);

  return output;
}

main() {
  var day = 9;
  var realData = "data/day${day}.txt";
  var testData = "data/day${day}_testData.txt";

  var processor_testData = processor9();
  readFileByLine(testData, processor_testData.callback, solve: () {
    print('<< test data result: ${processor_testData.pt1(preamble: 5)}');
  }, onComplete: () {
    var processor_pt1 = processor9();
    readFileByLine(realData, processor_pt1.callback, solve: () {
      print('<< part 1 >> result: ${processor_pt1.pt1(preamble: 25)}');
    }, onComplete: () {
      var processor_pt2 = processor9();
      readFileByLine(realData, processor_pt2.callback, solve: () {
        var window = processor_pt2.pt2(776203571);
        var smallest = window.reduce((a, b) => a < b ? a : b);
        var biggest = window.reduce((a, b) => a > b ? a : b);
        print('<< part 2 >> result window   : ${window}');
        print("<< part 2 >> result smallest : ${smallest}");
        print("<< part 2 >> result biggest  : ${biggest}");
        print("<< part 2 >> result sum      : ${biggest + smallest}");
      });
    });
  });
}
