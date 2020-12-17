import '../utils.dart';

class Processor {
  Function(String) callback;
  int Function() pt1;
  int Function() pt2;
}

Processor day14() {
  var output = Processor();

  List<String> input = [];

  output.callback = input.add;

  output.pt1 = () {
    // String mask = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
    // eg. all X would translate to nulls in all entries
    List<dynamic> masks = List(36);
    Map<int, int> memory = {};

    input.forEach((line) {
      if (line.startsWith("mask")) {
        for (int i = 0; i < masks.length ; i++) masks[i] = null;
        var mask = line.split("mask = ")[1].trim();
        print ("line processed as $mask");
        for (int i = 0; i < mask.length; i++) {
          var value = mask.substring(i, i+1);
          if (value == "1") masks[i] = 1;
          if (value == "0") masks[i] = 0;
        }
      } else {
        var stopIndex = line.indexOf("]");
        int memoryAddress = int.parse(line.substring(4, stopIndex));
        int value = int.parse(line.substring(line.indexOf("=") +1).trim());
        print('do a memory thing with $memoryAddress $value');

      }
    });

    return 0;
  };

  output.pt2 = () {
    return 0;
  };

  return output;
}

main() {
  var day = 14;
  var testData = "data/day${day}_testData.txt";
  var realData = "data/day${day}.txt";

  var processor_testData = day14();
  readFileByLine(testData, processor_testData.callback, solve: () {
    print('<< day $day pt 1 >> ${processor_testData.pt1()}');
  }, onComplete: () {
    var processor_pt1 = day14();
    readFileByLine(realData, processor_pt1.callback, solve: () {
      print('<< day $day pt 1 >> ${processor_pt1.pt1()}');
    }, onComplete: () {
      var processor_pt2 = day14();
      readFileByLine(realData, processor_pt2.callback, solve: () {
        print('<< day $day pt 2 >> ${processor_pt2.pt2()}');
      });
    });
  });
}
