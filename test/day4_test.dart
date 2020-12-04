import 'package:test/test.dart';
import '../day4.dart';

void main() {
  group('day 4 tests', () {
    group('passport detection', () {
      test('starts a new passport due to new line', () {
          var output = newProcessor();

          output.callback("");
      });
    });
  });
}
