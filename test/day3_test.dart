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

  group('implement move checking hits', () {
    test('land on a tree', () {
      var grid = new DataGrid();

      grid.addRow(["", "", "", ""]);
      grid.addRow(["", "#", "", ""]);

      grid.move(new Point(1, 1));

      expect(grid.hits, equals(1));
    });

    test('land on a tree twice', () {
      var grid = new DataGrid();

      grid.addRow(["", "", "", ""]);
      grid.addRow(["", "#", "", ""]);
      grid.addRow(["", "", "#", ""]);

      grid.move(new Point(1, 1));
      grid.move(new Point(1, 1));

      expect(grid.hits, equals(2));
    });

    test('land on an a non-tree space', () {
      var grid = new DataGrid();

      grid.addRow(["", "", "", ""]);
      grid.addRow(["", ".", "", ""]);

      grid.move(new Point(1, 1));

      expect(grid.hits, equals(0));
    });
  });

  group('implement move checking location', () {
    test('move down by 1', () {
      var grid = new DataGrid();

      grid.addRow(["", "", "", ""]);
      grid.addRow(["", "", "", ""]);

      grid.move(new Point(3, 1));

      expect(grid.location.y, equals(1));
    });

    test('move across by 2', () {
      var grid = new DataGrid();

      grid.addRow(["", "", "", ""]);
      grid.addRow(["", "", "", ""]);

      grid.move(new Point(2, 1));

      expect(grid.location.x, equals(2));
    });

    test('move across by more than grid size', () {
      var grid = new DataGrid();

      grid.addRow(["", "", "", ""]);
      grid.addRow(["", "", "", ""]);

      grid.move(new Point(6, 1));

      expect(grid.location.x, equals(2));
    });

    test('move across by more than grid size', () {
      var grid = new DataGrid();

      grid.addRow(["", "", "", ""]);
      grid.addRow(["", "", "", ""]);

      grid.move(new Point(7, 1));

      expect(grid.location.x, equals(3));
    });

    test('move across by more than grid size', () {
      var grid = new DataGrid();

      grid.addRow(["", "", "", ""]);
      grid.addRow(["", "", "", ""]);

      grid.move(new Point(8, 1));

      expect(grid.location.x, equals(0));
    });
  });
}
