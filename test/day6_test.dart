import 'package:test/test.dart';

import '../src/day6.dart';

main() {
  group("day 6", () {
    group("part 2", () {

      test("unique yes per person means no matches", (){
        var processor = newProcessor();

        var votes = ["a", "b", "c"];
        votes.forEach(processor.processLine);

        var result = processor.pt2();

        expect(result, equals(0));
      });

      test("if two people vote the same", (){
        var processor = newProcessor();

        var votes = ["ab", "bc"]; // b is the same
        votes.forEach(processor.processLine);

        var result = processor.pt2();

        expect(result, equals(1));
      });
      test("", (){});
    });

    group("part 1", () {
      test("considers valid guesses from input", () {
        var processor = newProcessor();

        var votes = ["a"];
        votes.forEach(processor.processLine);

        var result = processor.pt1();

        expect(result, equals(1));
      });

      test("ignores double counts", () {
        var processor = newProcessor();

        var votes = [
          "aaaa",
        ];
        votes.forEach(processor.processLine);

        var result = processor.pt1();

        expect(result, equals(1));
      });

      test("can count A again if from a different group", () {
        var processor = newProcessor();

        var votes = ["a", "a", "", "a"];
        votes.forEach(processor.processLine);

        var result = processor.pt1();

        expect(result, equals(2));
      });

      test("a person can count multiple correct votes", () {
        var processor = newProcessor();

        var votes = ["abc"];
        votes.forEach(processor.processLine);

        var result = processor.pt1();

        expect(result, equals(3));
      });
    });
  });
}
