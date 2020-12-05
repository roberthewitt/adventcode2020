import 'dart:math';

import '../utils.dart';

/*
BFFFBBFRRR: row 70, column 7, seat ID 567.
FFFBBBFRRR: row 14, column 7, seat ID 119.
BBFFBBFRLL: row 102, column 4, seat ID 820.

70*8 + 7
* */

class Processor {
  Function(String) processLine;
  int Function() calculateMaxSeatId;
  int Function() mySeat;
}

Processor newProcessor() {
  List<String> lines = [];
  List<Point<int>> getSeats() {
    int convertToNumber(String fb) {
      fb = fb.replaceAll("F", "0");
      fb = fb.replaceAll("L", "0");
      fb = fb.replaceAll("B", "1");
      fb = fb.replaceAll("R", "1");
      return int.parse(fb, radix: 2);
    }

    return lines
        .map((e) => Point<int>(
              convertToNumber(e.substring(7, 10)),
              convertToNumber(e.substring(0, 7)),
    )).toList();
  }

  int convertToSeatId ( Point<int> p ) => p.y * 8 + p.x;

  var output = Processor();
  output.processLine = lines.add;
  output.calculateMaxSeatId = () => getSeats()
      .map(convertToSeatId)
      .toList()
      .reduce((a, b) => a > b ? a : b);
  output.mySeat = () {
    var seats = getSeats();
    seats.sort((a, b) {
      if (a.y < b.y) return -1;
      if (a.y > b.y) return 1;
      if (a.x < b.x) return -1;
      return 1;
    });

    int padBy(String rowId) {
      switch (rowId.trim().length) {
        case 1:
        case 2:
          return 3;
        default:
          return 2;
      }
    }

    List<Point<int>> missingSeats = [];
    void hasMissing(String columnId, List<dynamic> seatIds) {
      for (int i = 1; i < seatIds.length -1; i++) {
        var previous = seatIds[i-1];
        var current = seatIds[i];
        var next = seatIds[i+1];
        if (current == "O" && next == "X" && previous == "X") {
          missingSeats.add(Point(i,int.parse(columnId)));
        }
      }
    }

    var columnId = null;
    var index = 0;
    List<dynamic> row = [];
    seats.forEach((element) {
      if (columnId == null) {
        columnId = element.y;
        row = [columnId];
      }
      if (columnId != element.y) {
        // print row
        var thisRowsColumnId = row.first.toString();
        thisRowsColumnId = thisRowsColumnId.padRight(padBy(thisRowsColumnId));
        var takenSeats = row.sublist(1);
        hasMissing(thisRowsColumnId, takenSeats);
        print('$thisRowsColumnId - $takenSeats');
        columnId = element.y;
        row = [columnId];
        index = 0;
      }

      var rowId = element.x;
      while (rowId != index) {
        row.add("O");
        index++;
      }
      row.add("X");
      index++;
    });

    print("missing seats: $missingSeats");

    return convertToSeatId(missingSeats[0]);
  };

  return output;
}

main() {
  var processor_testData = newProcessor();
  readFileByLine("data/day5_testData.txt", processor_testData.processLine,
      onComplete: () {
    print('<< test data highest seat: ${processor_testData.calculateMaxSeatId()}');
  });

 var processor_pt1 = newProcessor();
  readFileByLine("data/day5.txt", processor_pt1.processLine,
      onComplete: () {
    print('<< part 1 >> highest seat: ${processor_pt1.calculateMaxSeatId()}');
  });

  var processor_pt2 = newProcessor();
  readFileByLine("data/day5.txt", processor_pt2.processLine,
      onComplete: () {
    print('<< part 2 >> my seat: ${processor_pt2.mySeat()}');
  });
}
