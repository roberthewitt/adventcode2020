import 'package:test/test.dart';

import '../src/day1.dart';

main() {
  group("day 1 tests", () {
    test("the 2 numbers sum to the target of 10", () {
      var processor = newProcessor();
      processor.callback("8");
      processor.callback("2");

      expect(processor.findMatch(sum: 10, size: 2),
          equals("multiplying: [8, 2] = 16"));
    });

    test("can find 2 numbers in a set of 5", () {
      var processor = newProcessor();
      processor.callback("8");
      processor.callback("1");
      processor.callback("1");
      processor.callback("4");
      processor.callback("2");

      expect(processor.findMatch(sum: 10, size: 2),
          equals("multiplying: [8, 2] = 16"));
    });

    test("can find 3 numbers in a set of 5", () {
      var processor = newProcessor();
      processor.callback("1");
      processor.callback("2");
      processor.callback("4");
      processor.callback("5");
      processor.callback("3");

      expect(processor.findMatch(sum: 6, size: 3),
          equals("multiplying: [1, 2, 3] = 6"));
    });

    test("handles no match", () {
      var processor = newProcessor();
      processor.callback("1");
      processor.callback("2");
      processor.callback("4");
      processor.callback("5");
      processor.callback("7");

      expect(processor.findMatch(sum: 6, size: 3), equals("no match found"));
    });

    test("checking set of 6 in set of 10", () {
      var processor = newProcessor();
      processor.callback("1");
      processor.callback("5");
      processor.callback("4");
      processor.callback("4");
      processor.callback("3");
      processor.callback("1");
      processor.callback("5");
      processor.callback("6");
      processor.callback("5");
      processor.callback("77");
      processor.callback("1");
      processor.callback("1");
      processor.callback("7");
      processor.callback("1");
      processor.callback("2");

      expect(processor.findMatch(sum: 7, size: 6),
          equals("multiplying: [1, 1, 1, 1, 1, 2] = 2"));
    });
  });
}
