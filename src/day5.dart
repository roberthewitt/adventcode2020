import 'dart:math';

import '../utils.dart';

/*
BFFFBBFRRR: row 70, column 7, seat ID 567.
FFFBBBFRRR: row 14, column 7, seat ID 119.
BBFFBBFRLL: row 102, column 4, seat ID 820.

70*8 + 7
* */

int convertToNumber(String fb) {
  fb = fb.replaceAll("F", "0");
  fb = fb.replaceAll("L", "0");
  fb = fb.replaceAll("B", "1");
  fb = fb.replaceAll("R", "1");
  return int.parse(fb, radix: 2);
}

int calcSeatId(Point<int> p) => p.y * 8 + p.x;

class Processor {
  Function(String) processLine;
  int Function() calculateMaxSeatId;
  int Function() mySeat;
}

Processor newProcessor() {
  var output = Processor();

  List<Point<int>> seats = [];
  output.processLine = (line) {
    seats.add(Point<int>(
      convertToNumber(line.substring(7, 10)),
      convertToNumber(line.substring(0, 7)),
    ));
  };
  ;
  output.calculateMaxSeatId = () => seats.map(calcSeatId).reduce((a, b) => a > b ? a : b);
  output.mySeat = () {
    List<Point<int>> missingSeats = [];
    void hasMissing(String columnId, List<String> seatIds) {
      for (int i = 1; i < seatIds.length - 1; i++) {
        if (seatIds[i - 1] == "-" && seatIds[i] == "X" && seatIds[i + 1] == "-") {
          missingSeats.add(Point(i, int.parse(columnId)));
        }
      }
    }

    Map<int, List<String>> data = {};
    seats.forEach((seat) {
      if (data[seat.y] == null) data[seat.y] = ["X", "X", "X", "X", "X", "X", "X", "X"];
      List<String> row = data[seat.y];
      row[seat.x] = "-";
    });
    var sortedData = data.entries.toList();
    sortedData.sort((a, b) {
      if (a.key == b.key) return 0;
      if (a.key < b.key) return -1;
      return 1;
    });
    sortedData.forEach((rowData) {
      var fixedSizeId = rowData.key.toString();
      while (fixedSizeId.length != 5) fixedSizeId = fixedSizeId + " ";
      var takenSeats = rowData.value;
      hasMissing(fixedSizeId, takenSeats);
      print('$fixedSizeId - $takenSeats');
    });

    print("valid my seats: $missingSeats");

    if (missingSeats.isEmpty) return 0;
    return calcSeatId(missingSeats[0]);
  };

  return output;
}

main() {
  var processor_testData = newProcessor();
  readFileByLine("data/day5_testData.txt", processor_testData.processLine, solve: () {
    print('<< part 1 >> ${processor_testData.calculateMaxSeatId()}');
  }, onComplete: () {
    var processor_pt1 = newProcessor();
    readFileByLine("data/day5.txt", processor_pt1.processLine, solve: () {
      print('<< part 1 >> ${processor_pt1.calculateMaxSeatId()}');
    }, onComplete: () {
      var processor_pt2 = newProcessor();
      readFileByLine("data/day5.txt", processor_pt2.processLine, solve: () {
        print('<< part 2 >> ${processor_pt2.mySeat()}');
      });
    });
  });
}
