import 'dart:math';

import 'package:test/test.dart';

import '../src/day5.dart';

String Function(int) makeBinary(
        {String convertZeroTo, String convertOneTo, int maxLength}) =>
    (int value) {
      var newValue = value
          .toRadixString(2)
          .toString()
          .replaceAll("0", convertZeroTo)
          .replaceAll("1", convertOneTo);
      while (newValue.length != maxLength) newValue = convertZeroTo + newValue;
      return newValue;
    };

String Function(int) keyFromRow = (row) =>
    makeBinary(convertOneTo: "R", convertZeroTo: "L", maxLength: 3)(row);
String Function(int) keyFromColumn = (column) =>
    makeBinary(convertOneTo: "B", convertZeroTo: "F", maxLength: 7)(column);

String convert(Point<int> seat) =>
    "${keyFromColumn(seat.y)}${keyFromRow(seat.x)}";

main() {
  group('day 5 tests', () {
    group('calculate max seat id', () {
      test("FFFBBBFRRR: row 14, column 7, seat ID 119.", () {
        var processor = newProcessor();

        processor.processLine("FFFBBBFRRR");
        var result = processor.calculateMaxSeatId();

        expect(result, equals(119));
      });

      test("BFFFBBFRRR: row 70, column 7, seat ID 567.", () {
        var processor = newProcessor();

        processor.processLine("BFFFBBFRRR");
        processor.processLine("FFFBBBFRRR");

        var result = processor.calculateMaxSeatId();

        expect(result, equals(567));
      });

      test("BBFFBBFRLL: row 102, column 4, seat ID 820.", () {
        var processor = newProcessor();

        processor.processLine("BFFFBBFRRR");
        processor.processLine("FFFBBBFRRR");
        processor.processLine("BBFFBBFRLL");
        var result = processor.calculateMaxSeatId();

        expect(result, equals(820));
      });

      test("given seats are all in row 0, we choose highest seat", () {
        var processor = newProcessor();

        var column = keyFromColumn(0);
        var seats = [0, 1, 2, 3, 4, 5, 6, 7];
        seats
            .map(keyFromRow)
            .map((row) => "$column$row")
            .forEach(processor.processLine);

        var result = processor.calculateMaxSeatId();

        expect(result, equals(7));
      });
    });

    group('calculate missing seat', () {
      test('handles no missing seat', () {
        var processor = newProcessor();

        var result = processor.mySeat();

        expect(result, equals(0));
      });

      test('a missing seat needs seats on either side', () {
        var processor = newProcessor();

        // processor.processLine(convert(Point(0, 0)));
        // processor.processLine(convert(Point(1, 0)));
        // processor.processLine(convert(Point(2, 0)));
        processor.processLine(convert(Point(3, 0)));
        // processor.processLine(convert(Point(4, 0))); <-- winner
        processor.processLine(convert(Point(5, 0)));
        // processor.processLine(convert(Point(6, 0)));
        // processor.processLine(convert(Point(7, 0)));

        var result = processor.mySeat();

        expect(result, equals(4));
      });
    });
  });
}
