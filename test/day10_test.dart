import 'package:test/test.dart';

import '../src/day10.dart';

main() {
  group("day 10", () {
    group("part 1", () {
      test("dummy", () {
        var processor = day10();

        var lines = [""];
        lines.forEach(processor.callback);

        expect(processor.pt1(), equals(0));
      });
    });

    group("part 2", () {
      test("dummy", () {
        var processor = day10();

        var lines = [""];
        lines.forEach(processor.callback);

        expect(processor.pt2(), equals(0));
      });
    });
  });
}
