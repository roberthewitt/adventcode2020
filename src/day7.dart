import '../utils.dart';

class Processor {
  Function(String) callback;
  int Function() pt1;
  int Function() pt2;
}

Processor newProcessor() {
  var output = Processor();

  List<String> lines = [];
  output.callback = lines.add;

  output.pt1 = () => 0;

  output.pt2 = () => 0;

  return output;
}

main() {
  var processor_testData = newProcessor();
  readFileByLine("data/day7_testData.txt", processor_testData.callback,
      onComplete: () {
    print('<< test data result: ${processor_testData.pt1()}');
  });

  var processor_pt1 = newProcessor();
  readFileByLine("data/day7.txt", processor_pt1.callback, onComplete: () {
    print('<< part 1 >> result: ${processor_pt1.pt1()}');
  });

  var processor_pt2 = newProcessor();
  readFileByLine("data/day7.txt", processor_pt2.callback, onComplete: () {
    print('<< part 2 >> result: ${processor_pt2.pt2()}');
  });
}
