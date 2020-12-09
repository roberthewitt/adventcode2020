import 'package:test/test.dart';

import '../src/day9.dart';

main() {
  group("day 9", () {
    group("part 1", () {
      test("first number fail after preamble", () {
        var processor = processor9();

        var lines = ["2", "3", "6"];
        lines.forEach(processor.callback);

        expect(processor.pt1(preamble: 2), equals(6));
      });

      test("2nd number fail after preamble", () {
        var processor = processor9();

        var lines = ["2", "3", "5", "1"];
        lines.forEach(processor.callback);

        expect(processor.pt1(preamble: 2), equals(1));
      });

      test("if all numbers succeed, throw error", () {
        var processor = processor9();

        var lines = ["2", "3", "5", "8"];
        lines.forEach(processor.callback);

        expect(() => processor.pt1(preamble: 2), throwsStateError);
      });

    });

    group("part 2", () {
      test("dummy", () {
        var processor = processor9();

        var lines = ["1"];
        lines.forEach(processor.callback);

        expect(processor.pt2(), equals(0));
      });
    });
  });
}
