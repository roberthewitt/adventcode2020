import 'dart:math';

import 'package:test/test.dart';

import '../src/day3.dart';

void main() {
  group('canMove', () {

    test('try to move down by 1 when only 1 row', () {
      var processor = newProcessor();

      processor.callback("....");

      var result = processor.hits(new Point(1, 1));

      expect(result, equals(0),
          reason: "we should not be able to move by 1 down");
    });
  });

  group('implement move checking hits', () {
    test('land on a tree', () {
      var processor = newProcessor();

      processor.callback("....");
      processor.callback(".#..");

      var result = processor.hits(new Point(1, 1));

      expect(result, equals(1));
    });

    test('land on a tree twice', () {
      var processor = newProcessor();

      processor.callback("....");
      processor.callback(".#..");
      processor.callback("..#.");

      var result = processor.hits(new Point(1, 1));

      expect(result, equals(2));
    });

    test('land on an a non-tree space', () {
      var processor = newProcessor();

      processor.callback("....");
      processor.callback("....");
      processor.callback("....");

      var result = processor.hits(new Point(1, 1));

      expect(result, equals(0));
    });
  });

  group('implement move checking location', () {

    test('move across by 2', () {
      var processor = newProcessor();

      processor.callback("....");
      processor.callback("..#.");

      var result = processor.hits(new Point(2,1));

      expect(result, equals(1));
    });

    test('move across by more than grid size', () {
      var processor = newProcessor();

      processor.callback("...."); // o......#
      processor.callback("...#"); // ...#...#

      var result = processor.hits(new Point(7,1));

      expect(result, equals(1));
    });

  });
}
