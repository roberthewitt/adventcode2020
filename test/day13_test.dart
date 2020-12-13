import 'package:test/test.dart';

import '../src/day13.dart';

main() {
  group("day 13", () {
    group("part 1", () {
      test("stub", () {
        var processor = day13();

        var lines = [];
        lines.forEach(processor.callback);

        expect(processor.pt1(), equals(0));
      });
    });

    group("part 2", () {
      test("stub", () {
        var processor = day13();

        var lines = [];
        lines.forEach(processor.callback);

        expect(processor.pt2(), equals(0));
      });
    });
  });
}
