import '../utils.dart';

class Processor {
  Function(String) callback;
  int Function() pt1;
  int Function() pt2;
}

class Instruction {
  String type;
  int value;
  bool executed = false;

  Instruction(this.type, this.value);
}

class Operation {
  int jumpBy, increment;

  Operation({this.jumpBy, this.increment});
}

Processor newProcessor() {
  var output = Processor();

  List<Instruction> instructions = [];

  output.callback = (String line) {
    if (line.trim().length == 0) return;
    var type = line.substring(0, 3);
    var value = int.parse(line.substring(3, line.length));

    instructions.add(Instruction(type, value));
  };

  Operation getOrder(Instruction i) {
    int jumpBy = 1, increment = 0;

    switch (i.type) {
      case "acc":
        {
          increment = i.value;
          break;
        }
      case "jmp":
        {
          jumpBy = i.value;
          break;
        }
    }
    return Operation(jumpBy: jumpBy, increment: increment);
  }

  output.pt1 = () {
    int index = 0;
    int result = 0;
    Instruction current = instructions[index];

    while (!current.executed) {
      current.executed = true;
      var order = getOrder(current);
      result += order.increment;
      index += order.jumpBy;
      if (index < instructions.length) current = instructions[index];
    }

    return result;
  };

  output.pt2 = () {
    int result = 0;
    int modifyInstructionEncounter = 0;
    int instructionEncounter = 0;
    int maxTries = instructions.where((i) => ["jmp", "nop"].contains(i.type)).length;
    bool success = false;

    for (int i = 0, index = 0; i < maxTries && !success; i++,) {
      modifyInstructionEncounter++;
      instructionEncounter = 0;
      result = 0;
      index = 0;
      Instruction current = instructions[0];
      instructions.forEach((instr) {
        instr.executed = false;
      });

      while (!current.executed) {
        current.executed = true;

        if (["jmp", "nop"].contains(current.type)) instructionEncounter++;
        Instruction upFor = current;
        if (modifyInstructionEncounter == instructionEncounter) {
          switch (current.type) {
            case "jmp":
              {
                upFor = Instruction("nop", upFor.value);
                break;
              }
            case "nop":
              {
                upFor = Instruction("jmp", upFor.value);
                break;
              }
          }
        }
        var operation = getOrder(upFor);

        result += operation.increment;
        index += operation.jumpBy;
        if (index < instructions.length) current = instructions[index];
        if (index >= instructions.length) success = true;
      }
    }

    if (!success) print("didn't find a valid swap :( ");
    return result;
  };

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
