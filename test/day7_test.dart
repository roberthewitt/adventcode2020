import 'package:test/test.dart';

import '../src/day7.dart';

main() {
  group("day 7", () {

    group("part 1", () {
      test("can process line", () {
        var processor = newProcessor();

        var lines = ["light red bags contain 1 bright white bag, 2 muted yellow bags."];
        lines.forEach(processor.callback);

        var bright_white = processor.pt1("bright white");
        var muted_yellow = processor.pt1("muted yellow");

        expect(bright_white, equals(1));
        expect(muted_yellow, equals(1));
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
