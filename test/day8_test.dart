import 'package:test/test.dart';

import '../src/day8.dart';

main() {
  group("day 8", () {
    group("part 1", () {
      test("dummy", () {
        var processor = newProcessor();

        var lines = [""];
        lines.forEach(processor.callback);

        var result = processor.pt2();

        expect(result, equals(0));
      });
    });

    group("part 2", () {
      test("dummy", () {
        var processor = newProcessor();

        var lines = [""];
        lines.forEach(processor.callback);

        var result = processor.pt2();

        expect(result, equals(0));
      });
    });
  });
}
