import 'package:test/test.dart';

import '../src/day12.dart';

main() {
  group("day 11", () {
    group("part 1", () {

      test("moving forwards 5, then east 5 should equal 10", () {
        var processor = day12();

        var lines = [
          "F5",
          "E5",
        ];
        lines.forEach(processor.callback);

        expect(processor.pt1(), equals(10));

      });

      test("moving forwards 5, then west 5 should equal 0", () {
        var processor = day12();

        var lines = [
          "F5",
          "W5",
        ];
        lines.forEach(processor.callback);

        expect(processor.pt1(), equals(0));

      });


      test("test data", () {
        var processor = day12();

        var lines = [
          "F10",
          "N3",
          "F7",
          "R90",
          "F11",
        ];
        lines.forEach(processor.callback);

        expect(processor.pt1(), equals(25));
      });
    });

    group("part 2", () {
      test("test data", () {
        var processor = day12();

        var lines = [];
        lines.forEach(processor.callback);

        expect(processor.pt2(), equals(0));
      });
    });
  });
}
