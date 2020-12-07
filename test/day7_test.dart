import 'package:test/test.dart';

import '../src/day7.dart';

main() {
  group("day 7", () {

    group("part 1", () {
      test("gold", () {
        var processor = newProcessor();

        var lines = ["bright white bags contain 1 shiny gold bag."];
        lines.forEach(processor.callback);

        var result = processor.pt1("shiny gold");

        expect(result, equals(1));
      });
  test("can find bag in first element", () {
        var processor = newProcessor();

        var lines = ["light red bags contain 1 bright white bag, 2 muted yellow bags."];
        lines.forEach(processor.callback);

        var result = processor.pt1("bright white");

        expect(result, equals(1));
      });

      test("can find bag in 2nd element", () {
        var processor = newProcessor();

        var lines = ["light red bags contain 1 bright white bag, 2 muted yellow bags."];
        lines.forEach(processor.callback);

        var result = processor.pt1("muted yellow");

        expect(result, equals(1));
      });

      test("can find in multiple bags", () {
        var processor = newProcessor();

        var lines = [
          "light red bags contain 1 bright white bag, 2 muted yellow bags.",
          "blue pink bags contain 6 bright white bags.",
        ];
        lines.forEach(processor.callback);

        var result = processor.pt1("bright white");

        expect(result, equals(2));
      });

      test("handles ignore bags", () {
        var processor = newProcessor();

        var lines = [
          "blue pink bags contain 6 bright white bags.",
          "faded blue bags contain no other bags."
        ];
        lines.forEach(processor.callback);

        var result = processor.pt1("bright white");

        expect(result, equals(1));
      });

      test("bag that contains another bag of matching colour", () {
        var processor = newProcessor();

        var lines = [
          "red red bags contain 6 white white bags.",
          "blue blue bags contain 1 red red bag.",
        ];
        lines.forEach(processor.callback);

        var result = processor.pt1("white white");

        expect(result, equals(2));
      });
    });

    group("part 2", () {
      test("foo", () {
        var processor = newProcessor();

        var lines = ["a", "b", "c"];
        lines.forEach(processor.callback);

        var result = processor.pt2("foo bar");

        expect(result, equals(0));
      });
    });

  });
}
