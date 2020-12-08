import 'package:test/test.dart';

import '../src/day9.dart';

main() {
  group("day 9", () {
    group("part 1", () {
      test("dummy", () {
        var processor = newProcessor();

        var lines = [""];
        lines.forEach(processor.callback);

        expect(processor.pt1(), equals(0));
      });
    });

    group("part 2", () {
      test("dummy", () {
        var processor = newProcessor();

        var lines = [""];
        lines.forEach(processor.callback);

        expect(processor.pt2(), equals(0));
      });
    });
  });
}
