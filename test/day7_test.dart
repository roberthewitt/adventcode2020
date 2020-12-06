import 'package:test/test.dart';

import '../src/day7.dart';

main() {
  group("day 7", () {

    group("part 1", () {
      test("foo", () {
        var processor = newProcessor();

        var lines = ["a"];
        lines.forEach(processor.callback);

        var result = processor.pt1();

        expect(result, equals(0));
      });
    });

    group("part 2", () {
      test("foo", () {
        var processor = newProcessor();

        var lines = ["a", "b", "c"];
        lines.forEach(processor.callback);

        var result = processor.pt2();

        expect(result, equals(0));
      });
    });

  });
}
