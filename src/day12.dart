import 'dart:math';

import '../utils.dart';

class Processor {
  Function(String) callback;
  int Function() pt1;
  int Function() pt2;
}

Processor day12() {
  var output = Processor();

  List<String> lines = [];

  output.callback = lines.add;

  output.pt1 = () => part1Solution([...lines]);

  output.pt2 = () => 0;

  return output;
}

main() {
  var day = 12;
  var testData = "data/day${day}_testData.txt";
  var realData = "data/day${day}.txt";

  var processor_testData = day12();
  readFileByLine(testData, processor_testData.callback, solve: () {
    print('<< day $day pt 1 >> ${processor_testData.pt1()}');
  }, onComplete: () {
    var processor_pt1 = day12();
    readFileByLine(realData, processor_pt1.callback, solve: () {
      print('<< day $day pt 1 >> ${processor_pt1.pt1()}');
    }, onComplete: () {
      var processor_pt2 = day12();
      readFileByLine(realData, processor_pt2.callback, solve: () {
        print('<< day $day pt 2 >> ${processor_pt2.pt2()}');
      });
    });
  });
}

const FORWARDS = "F";
const BACKWARDS = "B";
const NORTH = "N";
const EAST = "E";
const SOUTH = "S";
const WEST = "W";
const LEFT = "L";
const RIGHT = "R";

int part1Solution(List<String> orders) {
  int facing = 180;

  var newLocation = orders.fold<Point>(Point(0, 0), (acc, order) {
    String direction = order.substring(0, 1);
    int magnitude = int.parse(order.substring(1, order.length));

    if (direction == FORWARDS) direction = translateDirection(facing);
    if (direction == BACKWARDS) direction = translateDirection(facing, reverse: false);

    if (direction == NORTH) acc += Point(0, magnitude);
    if (direction == SOUTH) acc += Point(0, -magnitude);
    if (direction == EAST) acc += Point(-magnitude, 0);
    if (direction == WEST) acc += Point(magnitude, 0);
    if (direction == LEFT) facing += magnitude;
    if (direction == RIGHT) facing -= magnitude;

    return acc;
  });

  var manhattan = newLocation.x.abs() + newLocation.y.abs();

  print("New Location : $newLocation");

  return manhattan;
}

String translateDirection(int facing, {bool reverse: true}) {
  if (facing == 0) return reverse ? WEST : EAST;
  if (facing == 90) return reverse ? SOUTH : NORTH;
  if (facing == 180) return reverse ? EAST : WEST;
  if (facing == 270)
    return reverse ? NORTH : SOUTH;
  else
    throw StateError("Unknown facing direction $facing");
}
