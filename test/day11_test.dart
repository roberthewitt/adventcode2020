import 'package:test/test.dart';

import '../src/day11.dart';

main() {
  group("day 11", () {
    group("part 1", () {
      test("flips all empty seats", () {
        var processor = day11();

        // 3x3 grid of seats
        var lines = [
          "LLL",
          "LLL",
          "LLL",
        ];
        lines.forEach(processor.callback);
        // should result in
        // [#, L, #]
        // [L, L, L]
        // [#, L, #]

        expect(processor.pt1(), equals(4));
      });

      test("4x4 empty", () {
        var processor = day11();

        var lines = [
          "LLLL",
          "LLLL",
          "LLLL",
          "LLLL",
        ];
        lines.forEach(processor.callback);
        // should result in
        // [#, L, L, #]
        // [L, L, L, L]
        // [L, L, L, L]
        // [#, L, L, #]

        expect(processor.pt1(), equals(4));
      });

      test("5x5 empty", () {
        var processor = day11();

        var lines = [
          "LLLLL",
          "LLLLL",
          "LLLLL",
          "LLLLL",
          "LLLLL",
        ];
        lines.forEach(processor.callback);
        // should result in
        // [#, L, #, L, #]
        // [L, L, L, L, L]
        // [#, L, #, L, #]
        // [L, L, L, L, L]
        // [#, L, #, L, #]

        expect(processor.pt1(), equals(9));
      });

      test("ignores .", () {
        var processor = day11();

        var lines = [
          ".....",
          "LLLLL",
          "LLLLL",
          "LLLLL",
          "LLLLL",
          "LLLLL",
        ];
        lines.forEach(processor.callback);
        // should result in
        // [., ., ., ., .]
        // [#, L, #, L, #]
        // [L, L, L, L, L]
        // [#, L, #, L, #]
        // [L, L, L, L, L]
        // [#, L, #, L, #]

        expect(processor.pt1(), equals(9));
      });

      test("test data", () {
        var processor = day11();

        var lines = [
          "L.LL.LL.LL",
          "LLLLLLL.LL",
          "L.L.L..L..",
          "LLLL.LL.LL",
          "L.LL.LL.LL",
          "L.LLLLL.LL",
          "..L.L.....",
          "LLLLLLLLLL",
          "L.LLLLLL.L",
          "L.LLLLL.LL"
        ];
        lines.forEach(processor.callback);

        expect(processor.pt1(), equals(37));
      });
    });

    group("part 2", () {

      test("test data", () {
        var processor = day11();

        var lines = [
          "L.LL.LL.LL",
          "LLLLLLL.LL",
          "L.L.L..L..",
          "LLLL.LL.LL",
          "L.LL.LL.LL",
          "L.LLLLL.LL",
          "..L.L.....",
          "LLLLLLLLLL",
          "L.LLLLLL.L",
          "L.LLLLL.LL"
        ];
        lines.forEach(processor.callback);

        expect(processor.pt2(), equals(26));
      });
    });
  });
}
