import '../utils.dart';

class Processor {
  Function(String) callback;
  int Function() pt1;
  int Function() pt2;
}

Processor newProcessor() {
  var output = Processor();

  List<List<String>> instr = [];
  output.callback = (line) => instr.add(line.split(" "));

  int part1(List<int> executed, {int index: 0, int result: 0}) {
    if (executed.contains(index)) return result;
    if (index == instr.length) return result;

    var operation = instr[index];
    var opcode = operation[0];

    if (opcode == 'jmp') return part1(executed += [index], index: index + int.parse(operation[1]), result: result);
    if (opcode == 'nop') return part1(executed += [index], index: index + 1, result: result);
    if (opcode == 'acc') return part1(executed += [index], index: index + 1, result: result + int.parse(operation[1]));
    throw ArgumentError("unknown opcode for #$index -> ${operation}");
  }

  const flippable = ["jmp", "nop"];
  int part2(List<int> executed, {int flipOpCode: 1}) {
    var maxFlips = instr.where((instruction) => flippable.contains(instruction[0])).length;
    if (flipOpCode > maxFlips) throw StateError("no more flips available");

    int index = 0, result = 0, opcodeMatchedAtLineIndex = 0, opcodeSeenCount = 0;
    bool success = false;
    do {
      executed += [index];
      if (index >= instr.length) {
        print("succeeded on modding opcode #${flipOpCode} at line#${opcodeMatchedAtLineIndex}");
        success = true;
        break;
      }
      var operation = instr[index];
      var opcode = operation[0];
      if (flippable.contains(opcode)) {
        opcodeSeenCount++;
        if (opcodeSeenCount == flipOpCode) {
          opcodeMatchedAtLineIndex = index;
          opcode = opcode == "jmp" ? "nop" : "jmp";
        }
      }
      if (opcode == "jmp") index += int.parse(operation[1]);
      if (opcode == "nop") index++;
      if (opcode == "acc") index++;
      if (opcode == "acc") result += int.parse(operation[1]);
      if (!['jmp', 'nop', 'acc'].contains(opcode)) throw ArgumentError("unknown opcode for #$index -> ${operation}");
    } while (!executed.contains(index));

    if (!success) return part2([], flipOpCode: flipOpCode + 1);
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
