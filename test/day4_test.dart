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

  group('edge casing', () {
    test('handles leading spaces on input line', () {
      var output = newProcessor();
      output.callback(" a:a");

      var passport = output.info.items.first;
      expect(passport.data.keys.length, equals(1));
    });

    test('handles trailing spaces on input line', () {
      var output = newProcessor();
      output.callback("a:a ");

      var passport = output.info.items.first;
      expect(passport.data.keys.length, equals(1));
    });
  });

  group('new rules for part 2', () {
    var validRules = {
      "pid": "087499704",
      "hgt": "74in",
      "ecl": "grn",
      "iyr": "2012",
      "eyr": "2030",
      "byr": "1980",
      "hcl": "#623a2f",
    };

    test('rules that work rules', () {
      var output = newProcessor();
      validRules.entries
          .map((e) => "${e.key}:${e.value}")
          .forEach(output.callback);

      var passport = output.info.items.first;
      expect(passport.isValid, equals(true));
    });

    group('birth year - byr', () {
      test('has less than 4 digits', (){
        var output = newProcessor();
        var broken = {
          ...validRules,
          "byr": "123"
        };
        broken.entries
            .map((e) => "${e.key}:${e.value}")
            .forEach(output.callback);

        var passport = output.info.items.first;
        expect(passport.isValid, equals(false));
      });

    });
  });

  group('can determine if a passport is valid', () {
    test('contains all 7 required fields', () {
      var output = newProcessor();
      output.callback("hcl:#ae17e1");
      output.callback("iyr:2013");
      output.callback("eyr:2024");
      output.callback("ecl:brn ");
      output.callback("pid:760753108");
      output.callback("byr:1931");
      output.callback("hgt:179cm");
      var passport = output.info.items.first;
      expect(passport.isValid, equals(true));
    });

    test('valid if we pass in all 8 options', () {
      var output = newProcessor();
      output.callback("hcl:#ae17e1");
      output.callback("iyr:2013");
      output.callback("eyr:2024");
      output.callback("ecl:brn ");
      output.callback("pid:760753108");
      output.callback("byr:1931");
      output.callback("hgt:179cm");
      // optional 8th field
      output.callback("cid:147");
      var passport = output.info.items.first;
      expect(passport.isValid, equals(true));
    });

    test('invalid valid if we are missing fields', () {
      var output = newProcessor();
      output.callback("hcl:#ae17e1");
      var passport = output.info.items.first;
      expect(passport.isValid, equals(false));
    });
  });
}
