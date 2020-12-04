import 'package:test/test.dart';

import '../day4.dart';

void main() {
  group('day 4 tests', () {
    group('new passport detection', () {
      test('starts a new passport due to new line', () {
        var output = newProcessor();
        output.callback("ecl:gry"); // start of first passport
        output.callback(""); // end of first passport
        output.callback("ecl:gry"); // should be 2nd passport

        expect(output.info.totalCount, equals(2));
      });

      test('starts a new passport due to new line with extra white space', () {
        var output = newProcessor();
        output.callback("ecl:gry"); // start of first passport
        output.callback("     "); // end of first passport
        output.callback("ecl:gry"); // should be 2nd passport

        expect(output.info.totalCount, equals(2));
      });
    });

    group('filling in passport fields', () {
      test('adds info to fields as key value pairs', () {
        var output = newProcessor();
        output.callback("a:# b:2 c:ccc");
        output.callback("d:d e:e f:f");

        var passport = output.info.items.first;
        expect(passport.data.keys.length, equals(6));
      });

      test('can pick a key/value pair into passport', () {
        var output = newProcessor();
        output.callback("a:1");

        var passport = output.info.items.first;
        expect(passport.data["a"], equals("1"));
      });
    });
  });
}
