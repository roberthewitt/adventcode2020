import 'package:test/test.dart';

import '../src/day8.dart';

main() {
  group("day 8", () {
    group("part 1", () {

      test("informs of an error of parsing opcode", () {
        var processor = newProcessor();

        var lines = ["abc 4"];
        lines.forEach(processor.callback);

        expect(() => processor.pt1(), throwsArgumentError);
      });

      test("no-op means do nothing", () {
        var processor = newProcessor();

        var lines = ["nop +0"];
        lines.forEach(processor.callback);

        var result = processor.pt1();

        expect(result, equals(0));
      });

      test("no-op skips to next line regardless of value", () {
        var processor = newProcessor();

        var lines = ["nop +66", "acc 4"];
        lines.forEach(processor.callback);

        var result = processor.pt1();

        expect(result, equals(4));
      });

      test("program exits when hit the end of statements", () {
        var processor = newProcessor();

        var lines = ["acc 4"];
        lines.forEach(processor.callback);

        var result = processor.pt1();

        expect(result, equals(4));
      });

      test("jump will goto line", () {
        var processor = newProcessor();

        var lines = [
          "jmp +3", //  1
          "acc 7", //      3
          "jmp 2", //        4
          "jmp -2", //    2
          "acc 3" //          5
        ];
        lines.forEach(processor.callback);

        var result = processor.pt1();

        expect(result, equals(10));
      });

      test("acc will add to total", () {
        var processor = newProcessor();

        var lines = ["acc +1", "nop +0"];
        lines.forEach(processor.callback);

        var result = processor.pt1();

        expect(result, equals(1));
      });

      test("acc can subtract", () {
        var processor = newProcessor();

        var lines = ["acc -5", "nop +0"];
        lines.forEach(processor.callback);

        var result = processor.pt1();

        expect(result, equals(-5));
      });

      test("exits if tries to repeat an instruction", () {
        var processor = newProcessor();

        var lines = [
          "acc +10",
          "acc -2",
          "jmp -1",
        ];
        lines.forEach(processor.callback);

        var result = processor.pt1();

        expect(result, equals(8));
      });
    });

    group("part 2", () {
      test("replaces the first jump with a nop", () {
        var processor = newProcessor();

        var lines = ["acc 4", "jmp -1", "acc 6"];
        lines.forEach(processor.callback);

        var result = processor.pt2();

        expect(result, equals(10));
      });

      test("informs of an error of parsing opcode", () {
        var processor = newProcessor();

        var lines = ["abc 4"];
        lines.forEach(processor.callback);

        expect(() => processor.pt2(), throwsArgumentError);
      });

      test("replaces the first nop with a jump", () {
        var processor = newProcessor();

        var lines = [
          "acc 1",
          "nop 2",
          "jmp -1",
          "acc 1",
        ];
        lines.forEach(processor.callback);

        var result = processor.pt2();

        expect(result, equals(2));
      });

      test("replaces the second nop with a jump", () {
        var processor = newProcessor();

        var lines = [
          "acc 5",
          "nop -1",
          "nop 1",
          "acc 2",
        ];
        lines.forEach(processor.callback);

        var result = processor.pt2();

        expect(result, equals(7));
      });

      test("replaces the second jmp with a nop", () {
        var processor = newProcessor();

        var lines = [
          "acc 5",
          "nop -1",
          "jmp -2",
          "acc 2",
        ];
        lines.forEach(processor.callback);

        var result = processor.pt2();

        expect(result, equals(7));
      });
    });
  });
}
