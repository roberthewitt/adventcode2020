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
    List<dynamic> masks = List(36);
    Map<int, int> memory = {};

    input.forEach((line) {
      if (line.startsWith("mask")) {
        var mask = line.split("mask = ")[1].trim();
        for (int i = 0; i < mask.length; i++) {
          var value = mask.substring(i, i + 1);
          if (value == "1") masks[i] = 1;
          if (value == "X") masks[i] = "X";
          if (value == "0") masks[i] = 0;
        }
      } else {
        int memoryAddress = int.parse(line.substring(4, line.indexOf("]")));
        int number = int.parse(line.substring(line.indexOf("=") + 1).trim());
        var binaryNumber = number.toRadixString(2).trim().padLeft(36, "0");

        var newValue = applyMask(binaryNumber, masks);

        var newNumber = int.parse(newValue, radix: 2);

        memory[memoryAddress] = newNumber;

        log('memory index $memoryAddress'
            '\nvalue  :$binaryNumber '
            '\nmask   :${maskToString(masks)} '
            '\nresult :$newValue '
            '\ndecimal:$newNumber');
      }
    });

    return memory.values.fold(0, (acc, val) => acc + val);
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

String maskToString(List<dynamic> masks) => masks.fold("", (acc, e) => acc + e.toString());

String applyMask(String binaryString, List<dynamic> masks) {
  var a = binaryString.split("");

  var result = "";
  for (int i = 0; i < a.length; i++) {
    var maskedBit = masks[i];
    switch (maskedBit) {
      case 1:
        {
          result += "1";
          break;
        }
      case 0:
        {
          result += "0";
          break;
        }
      default:
        {
          result += a[i];
        }
    }
  }

  return result;
}

void log(dynamic any) {
  if (false) print(any);
}
