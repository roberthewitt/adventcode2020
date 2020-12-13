import 'package:test/test.dart';

import '../src/day13.dart';

main() {
  group("day 13", () {
    group("part 1", () {
      // test("stub", () {
      //   var processor = day13();
      //
      //   var lines = [];
      //   lines.forEach(processor.callback);
      //
      //   expect(processor.pt1(), equals(0));
      // });

      test("test data", () {
        var processor = day13();

        var lines = [
          "939",
          "7,13,x,x,59,x,31,19",
        ];
        lines.forEach(processor.callback);

        expect(processor.pt1(), equals(5 * 59));
      });

      test("can work out departure time of single bus", () {
        var processor = day13();

        var lines = ["10", "12"];
        lines.forEach(processor.callback);

        expect(processor.pt1(), equals(2 * 12));
      });

      test("can work out departure time of multiple bus", () {
        var processor = day13();

        var lines = ["10", "12,11"];
        lines.forEach(processor.callback);

        expect(processor.pt1(), equals(1 * 11));
      });

      test("ignores x's in the bus ids", () {
        var processor = day13();

        var lines = ["10", "12,x,11"];
        lines.forEach(processor.callback);

        expect(processor.pt1(), equals(1 * 11));
      });
    });

    group("part 2", () {
      // test("stub", () {
      //   var processor = day13();
      //
      //   var lines = [];
      //   lines.forEach(processor.callback);
      //
      //   expect(processor.pt2(), equals(0));
      // });
    });
  });
}
