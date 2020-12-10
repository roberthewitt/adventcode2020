import 'package:test/test.dart';

import '../src/day10.dart';

main() {
  group("day 10", () {
    group("part 1", () {
      test("two 1's and one 3", () {
        var processor = day10();

        var lines = [
          "1",  // 1 difference
          "2",  // 1 difference
          "5",  // 3 difference
          "8",  // 3 difference
          "11", // 3 difference
        ];
        lines.forEach(processor.callback);

        expect(processor.pt1(), equals(8)); // 2 * 4
      });

      test("a single 1 adapter", () {
        var processor = day10();

        var lines = [
          "1",  // 1 difference
        ];
        lines.forEach(processor.callback);

        expect(processor.pt1(), equals(1)); // 1 * 1
      });

      test("input two 1's and one 3 jumbled up", () {
        var processor = day10();

        var lines = [
          "1",  // 1 difference
          "2",  // 1 difference
          "5",  // 3 difference
          "8",  // 3 difference
          "11", // 3 difference
        ];
        lines.shuffle();
        lines.forEach(processor.callback);

        expect(processor.pt1(), equals(8)); // 2 * 4
      });
    });

    group("part 2", () {
      test("dummy", () {
        var processor = day10();

        var lines = ["1"];
        lines.forEach(processor.callback);

        expect(processor.pt2(), equals(0));
      });
    });
  });
}
