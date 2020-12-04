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

    group('byr (Birth Year)', () {
      var key = 'byr';
      test('has less than 4 digits', () {
        var output = newProcessor();
        var broken = {...validRules, key: "123"};
        broken.entries
            .map((e) => "${e.key}:${e.value}")
            .forEach(output.callback);

        var passport = output.info.items.first;
        expect(passport.isValid, equals(false));
      });

      test('has more than 4 digits', () {
        var output = newProcessor();
        var broken = {...validRules, key: "12345"};
        broken.entries
            .map((e) => "${e.key}:${e.value}")
            .forEach(output.callback);

        var passport = output.info.items.first;
        expect(passport.isValid, equals(false));
      });

      test('is below 1920', () {
        var output = newProcessor();
        var broken = {...validRules, key: "1919"};
        broken.entries
            .map((e) => "${e.key}:${e.value}")
            .forEach(output.callback);

        var passport = output.info.items.first;
        expect(passport.isValid, equals(false));
      });

      test('is equal 1920', () {
        var output = newProcessor();
        var broken = {...validRules, key: "1920"};
        broken.entries
            .map((e) => "${e.key}:${e.value}")
            .forEach(output.callback);

        var passport = output.info.items.first;
        expect(passport.isValid, equals(true));
      });

      test('is above 2002', () {
        var output = newProcessor();
        var broken = {...validRules, key: "2003"};
        broken.entries
            .map((e) => "${e.key}:${e.value}")
            .forEach(output.callback);

        var passport = output.info.items.first;
        expect(passport.isValid, equals(false));
      });

      test('is equal 2002', () {
        var output = newProcessor();
        var broken = {...validRules, key: "2002"};
        broken.entries
            .map((e) => "${e.key}:${e.value}")
            .forEach(output.callback);

        var passport = output.info.items.first;
        expect(passport.isValid, equals(true));
      });
    });

    group('iyr (Issue Year)', () {
      var key = 'iyr';
      test('has less than 4 digits', () {
        var output = newProcessor();
        var broken = {...validRules, key: "123"};
        broken.entries
            .map((e) => "${e.key}:${e.value}")
            .forEach(output.callback);

        var passport = output.info.items.first;
        expect(passport.isValid, equals(false));
      });

      test('has more than 4 digits', () {
        var output = newProcessor();
        var broken = {...validRules, key: "12345"};
        broken.entries
            .map((e) => "${e.key}:${e.value}")
            .forEach(output.callback);

        var passport = output.info.items.first;
        expect(passport.isValid, equals(false));
      });

      test('is below 2010', () {
        var output = newProcessor();
        var broken = {...validRules, key: "2009"};
        broken.entries
            .map((e) => "${e.key}:${e.value}")
            .forEach(output.callback);

        var passport = output.info.items.first;
        expect(passport.isValid, equals(false));
      });

      test('is equal 2010', () {
        var output = newProcessor();
        var broken = {...validRules, key: "2010"};
        broken.entries
            .map((e) => "${e.key}:${e.value}")
            .forEach(output.callback);

        var passport = output.info.items.first;
        expect(passport.isValid, equals(true));
      });

      test('is above 2020', () {
        var output = newProcessor();
        var broken = {...validRules, key: "2021"};
        broken.entries
            .map((e) => "${e.key}:${e.value}")
            .forEach(output.callback);

        var passport = output.info.items.first;
        expect(passport.isValid, equals(false));
      });

      test('is equal 2020', () {
        var output = newProcessor();
        var broken = {...validRules, key: "2020"};
        broken.entries
            .map((e) => "${e.key}:${e.value}")
            .forEach(output.callback);

        var passport = output.info.items.first;
        expect(passport.isValid, equals(true));
      });
    });

    group('eyr (Expiration Year)', () {
      var key = 'eyr';
      test('has less than 4 digits', () {
        var output = newProcessor();
        var broken = {...validRules, key: "123"};
        broken.entries
            .map((e) => "${e.key}:${e.value}")
            .forEach(output.callback);

        var passport = output.info.items.first;
        expect(passport.isValid, equals(false));
      });

      test('has more than 4 digits', () {
        var output = newProcessor();
        var broken = {...validRules, key: "12345"};
        broken.entries
            .map((e) => "${e.key}:${e.value}")
            .forEach(output.callback);

        var passport = output.info.items.first;
        expect(passport.isValid, equals(false));
      });

      test('is below 2020', () {
        var output = newProcessor();
        var broken = {...validRules, key: "2019"};
        broken.entries
            .map((e) => "${e.key}:${e.value}")
            .forEach(output.callback);

        var passport = output.info.items.first;
        expect(passport.isValid, equals(false));
      });

      test('is equal 2020', () {
        var output = newProcessor();
        var broken = {...validRules, key: "2020"};
        broken.entries
            .map((e) => "${e.key}:${e.value}")
            .forEach(output.callback);

        var passport = output.info.items.first;
        expect(passport.isValid, equals(true));
      });

      test('is above 2030', () {
        var output = newProcessor();
        var broken = {...validRules, key: "2031"};
        broken.entries
            .map((e) => "${e.key}:${e.value}")
            .forEach(output.callback);

        var passport = output.info.items.first;
        expect(passport.isValid, equals(false));
      });

      test('is equal 2030', () {
        var output = newProcessor();
        var broken = {...validRules, key: "2030"};
        broken.entries
            .map((e) => "${e.key}:${e.value}")
            .forEach(output.callback);

        var passport = output.info.items.first;
        expect(passport.isValid, equals(true));
      });
    });

    group('hgt (Height)', () {
      var key = 'hgt';

      group('inches', () {
        test('does not end in in', () {
          var output = newProcessor();
          var broken = {...validRules, key: "66"};
          broken.entries
              .map((e) => "${e.key}:${e.value}")
              .forEach(output.callback);

          var passport = output.info.items.first;
          expect(passport.isValid, equals(false));
        });

        test('ends in in where at lower limit', () {
          var output = newProcessor();
          var broken = {...validRules, key: "59in"};
          broken.entries
              .map((e) => "${e.key}:${e.value}")
              .forEach(output.callback);

          var passport = output.info.items.first;
          expect(passport.isValid, equals(true));
        });

        test('ends in in where is below lower limit', () {
          var output = newProcessor();
          var broken = {...validRules, key: "58in"};
          broken.entries
              .map((e) => "${e.key}:${e.value}")
              .forEach(output.callback);

          var passport = output.info.items.first;
          expect(passport.isValid, equals(false));
        });

        test('ends in in where at upper limit', () {
          var output = newProcessor();
          var broken = {...validRules, key: "76in"};
          broken.entries
              .map((e) => "${e.key}:${e.value}")
              .forEach(output.callback);

          var passport = output.info.items.first;
          expect(passport.isValid, equals(true));
        });

        test('ends in in where is above upper limit', () {
          var output = newProcessor();
          var broken = {...validRules, key: "77in"};
          broken.entries
              .map((e) => "${e.key}:${e.value}")
              .forEach(output.callback);

          var passport = output.info.items.first;
          expect(passport.isValid, equals(false));
        });
      });

      group('centimeters', () {
        test('does not end in cm', () {
          var output = newProcessor();
          var broken = {...validRules, key: "159"};
          broken.entries
              .map((e) => "${e.key}:${e.value}")
              .forEach(output.callback);

          var passport = output.info.items.first;
          expect(passport.isValid, equals(false));
        });

        test('where at lower limit', () {
          var output = newProcessor();
          var broken = {...validRules, key: "150cm"};
          broken.entries
              .map((e) => "${e.key}:${e.value}")
              .forEach(output.callback);

          var passport = output.info.items.first;
          expect(passport.isValid, equals(true));
        });

        test('ends in in where is below lower limit', () {
          var output = newProcessor();
          var broken = {...validRules, key: "149cm"};
          broken.entries
              .map((e) => "${e.key}:${e.value}")
              .forEach(output.callback);

          var passport = output.info.items.first;
          expect(passport.isValid, equals(false));
        });

        test('ends in in where at upper limit', () {
          var output = newProcessor();
          var broken = {...validRules, key: "193cm"};
          broken.entries
              .map((e) => "${e.key}:${e.value}")
              .forEach(output.callback);

          var passport = output.info.items.first;
          expect(passport.isValid, equals(true));
        });

        test('ends in in where is above upper limit', () {
          var output = newProcessor();
          var broken = {...validRules, key: "194cm"};
          broken.entries
              .map((e) => "${e.key}:${e.value}")
              .forEach(output.callback);

          var passport = output.info.items.first;
          expect(passport.isValid, equals(false));
        });
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
