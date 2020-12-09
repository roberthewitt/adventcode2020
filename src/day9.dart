import '../utils.dart';
import 'day1.dart';

class Processor {
  Function(String) callback;
  int Function({int preamble}) pt1;
  int Function() pt2;
}

Processor processor9() {
  var output = Processor();

  List<int> lines = [];
  output.callback = (str) => lines.add(int.parse(str));

  int part1 ({int index, int size}) {
    var window = lines.sublist(index, size + index);
    var sum = lines[index + size];
    // print("searching for sum:$sum in $window from source:$lines ");
    var result = findTupleOf(window, 2, sum, []);
    if (result.isEmpty) return sum;
    if (index +1 + size  >= lines.length) {
      throw StateError("No match using window:${window} for sum: $sum");
    }
    return part1(index: index +1, size: size);
  }
  output.pt1 = ({int preamble}) => part1(index: 0, size: preamble);
  output.pt2 = () => 0;

  return output;
}

main() {
  var day = 9;
  var realData = "data/day${day}.txt";
  var testData = "data/day${day}_testData.txt";

  var processor_testData = processor9();
  readFileByLine(testData, processor_testData.callback, onComplete: () {
    print('<< test data result: ${processor_testData.pt1(preamble: 5)}');

    var processor_pt1 = processor9();
    readFileByLine(realData, processor_pt1.callback, onComplete: () {
      print('<< part 1 >> result: ${processor_pt1.pt1(preamble: 25)}');

      var processor_pt2 = processor9();
      readFileByLine(realData, processor_pt2.callback, onComplete: () {
        print('<< part 2 >> result: ${processor_pt2.pt2()}');
      });
    });
  });
}
