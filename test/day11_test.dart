import 'package:test/test.dart';

import '../src/day11.dart';

main() {
  group("day 11", () {
    group("part 1", () {
      test("can fill seats", () {
        var processor = day11();

        // 5x5 grid of seats
        var lines = [
          "LLLLL",
          "LLLLL",
          "LLLLL",
          "LLLLL",
          "LLLLL",
        ];
        lines.forEach(processor.callback);

        expect(processor.pt1(), equals(0));
      });
    });

    group("part 2", () {
      test("dummy", () {
        var processor = day11();

        var lines = [""];
        lines.forEach(processor.callback);

        expect(processor.pt2(), equals(0));
      });
    });
  });
}
