import 'package:test/test.dart';

import '../src/day14.dart';

main() {
  group("day 14", () {
    group("part 1", () {
      // test("stub", () {
      //   var processor = day13();
      //
      //   var lines = [];
      //   lines.forEach(processor.callback);
      //
      //   expect(processor.pt1(), equals(0));
      // });

      test("test example", () {
        var processor = day14();

        var lines = [
          "mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X",
          "mem[8] = 11",
          "mem[7] = 101",
          "mem[8] = 0",
        ];
        lines.forEach(processor.callback);

        expect(processor.pt1(), equals(165));
      });
    });

    group("part 2", () {
      // test("stub", () {
      //   var processor = day13();
      //
      //   var lines = [];
      //   lines.forEach(processor.callback);
      //
      //   expect(processor.pt2(), equals(0));
      // });

      test("test data", () {
        var processor = day14();

        var lines = [
          "mask = 000000000000000000000000000000X1001X",
          "mem[42] = 100",
          "mask = 00000000000000000000000000000000X0XX",
          "mem[26] = 1",
        ];
        lines.forEach(processor.callback);

        expect(processor.pt2(), equals(208));
      });
    });
  });
}
