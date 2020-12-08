import '../utils.dart';

class Processor {
  Function(String) callback;
  int Function() pt1;
  int Function() pt2;
}

Processor newProcessor() {
  var output = Processor();

  List<String> instr = [];
  output.callback = instr.add;

  int part1(List<int> executed, {int index: 0, int result: 0}) {
    if (executed.contains(index)) return result;
    if (index == instr.length) return result;

    var operation = instr[index].split(" ");
    var opcode = operation[0];
    var value = int.parse(operation[1]);

    if (opcode == 'jmp') return part1(executed += [index], index: index + value, result: result);
    if (opcode == 'nop') return part1(executed += [index], index: index + 1, result: result);
    if (opcode == 'acc') return part1(executed += [index], index: index + 1, result: result + value);
    throw ArgumentError("unknown opcode for #$index -> ${operation}");
  }

  int part2(List<int> executed, {int index: 0, int result: 0, int modOpCode: 1, int opCodeSeen: 0}) {
    bool success = false;
    int opcodeLineIndex = 0;
    do {
      executed += [index];
      if (index >= instr.length) {
        print("succeeded on modding opcode #${modOpCode} at line#${opcodeLineIndex}");
        success = true;
        break;
      }
      var operation = instr[index].split(" ");
      var opcode = operation[0];
      var value = int.parse(operation[1]);
      if (["jmp", "nop"].contains(opcode)) {
        opCodeSeen++;
        if (opCodeSeen == modOpCode) {
          opcodeLineIndex = index;
          opcode = opcode == "jmp" ? "nop" : "jmp";
        }
      }

      if (opcode == "jmp") index += value;
      if (opcode == "nop") index++;
      if (opcode == "acc") index++;
      if (opcode == "acc") result += value;
      if (!['jmp', 'nop', 'acc'].contains(opcode)) throw ArgumentError("unknown opcode for #$index -> ${operation}");
    } while (!executed.contains(index));

    if (!success) return part2([], modOpCode: modOpCode + 1);
    return result;
  }

  output.pt1 = () => part1([]);
  output.pt2 = () => part2([]);

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
