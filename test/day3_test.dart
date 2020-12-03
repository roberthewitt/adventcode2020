import 'dart:math';

import 'package:test/test.dart';

import '../day3.dart';

void main() {
  group('canMove', () {
    test('try to move down by 1', () {
      var grid = new DataGrid();

      grid.addRow(["", "", "", ""]);
      grid.addRow(["", "", "", ""]);

      var result = grid.canMove(new Point(1, 1));

      expect(result, equals(true),
          reason: "we should be able to move by 1 down");
    });

    test('try to move down by 1 when only 1 row', () {
      var grid = new DataGrid();

      grid.addRow(["", "", "", ""]);

      var result = grid.canMove(new Point(1, 1));

      expect(result, equals(false),
          reason: "we should not be able to move by 1 down");
    });
  });
}
