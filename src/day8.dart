import '../utils.dart';

class Processor {
  Function(String) callback;
  int Function() pt1;
  int Function() pt2;
}

class Instruction {
  String type;
  int jumpBy;
  int increment;
  bool executed = false;

  Instruction(this.type, {this.jumpBy = 1, this.increment = 0});

  @override
  String toString() {
    return 'Instruction{type: $type, jumpBy: $jumpBy, increment: $increment}';
  }
}

Processor newProcessor() {
  var output = Processor();

  List<Instruction> instructions = [];
  var transform = (String line) {
    if (line.trim().length == 0) return;
    var type = line.substring(0, 3);
    var value = int.parse(line.substring(3, line.length));
    int jumpBy = 1;
    int increment = 0;
    switch (type) {
      case "acc":
        {
          increment = value;
          break;
        }
      case "jmp":
        {
          jumpBy = value;
        }
    }

    instructions.add(Instruction(type, increment: increment, jumpBy: jumpBy));
  };
  output.callback = transform;

  output.pt1 = () {
    int index = 0;
    int result = 0;
    Instruction current = instructions[index];

    while (!current.executed) {
      current.executed = true;
      result += current.increment;
      index += current.jumpBy;
      if (index < instructions.length) current = instructions[index];
    }

    return result;
  };

  output.pt2 = () => 0;

  return output;
}

main() {
  var day = 8;
  var realData = "data/day${day}.txt";
  var testData = "data/day${day}_testData.txt";

  var processor_testData = newProcessor();
  readFileByLine(testData, processor_testData.callback, onComplete: () {
    print('<< test data result: ${processor_testData.pt1()}');

    var processor_pt1 = newProcessor();
    readFileByLine(realData, processor_pt1.callback, onComplete: () {
      print('<< part 1 >> result: ${processor_pt1.pt1()}');

      var processor_pt2 = newProcessor();
      readFileByLine(realData, processor_pt2.callback, onComplete: () {
        print('<< part 2 >> result: ${processor_pt2.pt2()}');
      });
    });
  });
}
