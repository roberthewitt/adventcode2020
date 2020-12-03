import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../day2.dart';

class PasswordCheckerMock extends Mock with PasswordChecker {}

void main() {
  group('passesRules', () {
    test('if a checker returns false', () {
      var checker = PasswordCheckerMock();
      when(checker.isValid("")).thenReturn(false);

      var result = passesRules("", [checker]);

      expect(result, equals(false));
    });

    test('if a checker returns true', () {
      var checker = PasswordCheckerMock();
      when(checker.isValid("")).thenReturn(true);

      var result = passesRules("", [checker]);

      expect(result, equals(true));
    });

    test('two checkers where 1 returns false and 1 returns true', () {
      var checkerTrue = PasswordCheckerMock();
      when(checkerTrue.isValid("")).thenReturn(true);
      var checkerFalse = PasswordCheckerMock();
      when(checkerFalse.isValid("")).thenReturn(false);

      var result = passesRules("", [checkerTrue, checkerFalse]);

      expect(result, equals(false));
    });
  });

  group('position rule checks', () {
    test('no matching character at either position', () {
      var key = "1-2 a : bb";
      var rule = getPositionRule(key);
      var password = getPassword(key);

      expect(rule.isValid(password), equals(false),
          reason: "password of $password should fail : $rule");
    });

    test('a matching character at one of the locations', () {
      var key = "1-2 a : ab";
      var rule = getPositionRule(key);
      var password = getPassword(key);

      expect(rule.isValid(password), equals(true),
          reason: "password of $password should pass : $rule");
    });

    test('a matching character at both of the locations', () {
      var key = "1-2 a : aa";
      var rule = getPositionRule(key);
      var password = getPassword(key);

      expect(rule.isValid(password), equals(false),
          reason: "password of $password should fail : $rule");
    });
  });

  group('maxMin password rule', () {
    test('expect a failure as no matching character', () {
      var key = "1-4 a: bcd";
      var rule = getMaxMinRule(key);
      var password = getPassword(key);

      expect(rule.isValid(password), equals(false),
          reason: "password of $password should fail : $rule");
    });

    test('expect a failure as not enough matching characters', () {
      var key = "2-4 a: abc";
      var rule = getMaxMinRule(key);
      var password = getPassword(key);

      expect(rule.isValid(password), equals(false),
          reason: "password of $password should fail : $rule");
    });

    test('expect a failure as exceeds maximum count', () {
      var key = "1-4 a: aaabcaaaaaaaa";
      var rule = getMaxMinRule(key);
      var password = getPassword(key);

      expect(rule.isValid(password), equals(false),
          reason: "password of $password should fail : $rule");
    });

    test('expect a positive match as matches minimum count', () {
      var key = "1-4 a: abc";
      var rule = getMaxMinRule(key);
      var password = getPassword(key);

      expect(rule.isValid(password), equals(true),
          reason: "password of $password should pass : $rule");
    });

    test('expect a positive match as in-between range maximum count', () {
      var key = "1-4 a: aabca";
      var rule = getMaxMinRule(key);
      var password = getPassword(key);

      expect(rule.isValid(password), equals(true),
          reason: "password of $password should pass : $rule");
    });

    test('expect a positive match as matches maximum count', () {
      var key = "1-4 a: aaabca";
      var rule = getMaxMinRule(key);
      var password = getPassword(key);

      expect(rule.isValid(password), equals(true),
          reason: "password of $password should pass : $rule");
    });
  });

  group('MaxMinRule decoding', () {
    test('1-2 v: pwbr', () {
      var rule = getMaxMinRule('1-2 v: pwbr');

      expect(rule.minimum, equals(1));
      expect(rule.maximum, equals(2));
      expect(rule.character, equals("v"));
    });
  });

  group('PositionRule decoding', () {
    test('1-2 v: pwbr', () {
      var rule = getPositionRule("1-2 v: pwbr");

      expect(rule.character, equals("v"));
      expect(rule.atPosition, equals([1, 2]));
    });
  });

  group('getPassword', () {
    test('1-2 v: pwbr', () {
      var password = getPassword('1-2 v: pwbr');
      expect(password, equals("pwbr"));
    });
  });
}
