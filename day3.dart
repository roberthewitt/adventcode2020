import 'dart:convert';
import 'dart:io';

void main() {
  int treesHit = 0;
  new File("inputData_day3.txt")
      .openRead()
      .map(utf8.decode)
      .transform(new LineSplitter())
      .forEach((element) {})
      .whenComplete(() {
    print('trees hit: ${treesHit}');
  });
}
