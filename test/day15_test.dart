import 'package:test/test.dart';

import '../src/day15.dart';

main() {
  group("day 15", () {
    group("part 1", () {
      // test("stub", () {
      //   var processor = day15();
      //
      //   var lines = [];
      //   lines.forEach(processor.callback);
      //
      //   expect(processor.pt1(), equals(0));
      // });

      test("1,3,2", () {
        var processor = day15();

        var lines = ["1,3,2"];
        lines.forEach(processor.callback);

        expect(processor.pt1(), equals(1));
      });

      test("2,1,3", () {
        var processor = day15();

        var lines = ["2,1,3"];
        lines.forEach(processor.callback);

        expect(processor.pt1(), equals(10));
      });

      test("3,1,2", () {
        var processor = day15();

        var lines = ["3,1,2"];
        lines.forEach(processor.callback);

        expect(processor.pt1(), equals(1836));
      });

    });

    group("part 2", () {
      // test("stub", () {
      //   var processor = day15();
      //
      //   var lines = [];
      //   lines.forEach(processor.callback);
      //
      //   expect(processor.pt2(), equals(0));
      // });

      test("Given 0,3,6, the 30000000th number spoken is 175594.", () {
        var processor = day15();

        var lines = ["0,3,6"];
        lines.forEach(processor.callback);

        expect(processor.pt2(), equals(175594));
      });

    });
  });
}
