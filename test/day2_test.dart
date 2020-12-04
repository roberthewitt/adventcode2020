import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../src/day2.dart';

class PasswordCheckerMock extends Mock with PasswordChecker {}

void main() {
  group('position rule checks', () {
    test('no matching character at either position', () {
      var processor = newProcessor();

      var key = "1-2 a : bb";
      processor.callback(key);
      var result = processor.valid(PositionFactory());

      expect(result, equals(0), reason: "$key should fail");
    });

    test('matching character at both of the locations', () {
      var key = "1-2 a : aa";
      var processor = newProcessor();
      processor.callback(key);
      var result = processor.valid(PositionFactory());

      expect(result, equals(0), reason: "$key should fail");
    });

    test('matching character at one of the locations', () {
      var key = "1-2 a : ab";
      var processor = newProcessor();
      processor.callback(key);
      var result = processor.valid(PositionFactory());

      expect(result, equals(1), reason: "$key should pass");
    });

  });

  group('maxMin password rule', () {
    test('expect a failure as no matching character', () {
      var key = "1-4 a: bcd";
      var processor = newProcessor();
      processor.callback(key);
      var result = processor.valid(MaxMinFactory());

      expect(result, equals(0), reason: "$key should fail");
    });

    test('expect a failure as not enough matching characters', () {
      var key = "2-4 a: abc";
      var processor = newProcessor();
      processor.callback(key);
      var result = processor.valid(MaxMinFactory());

      expect(result, equals(0), reason: "$key should fail");
    });

    test('expect a failure as exceeds maximum count', () {
      var key = "1-4 a: aaabcaaaaaaaa";
      var processor = newProcessor();
      processor.callback(key);
      var result = processor.valid(MaxMinFactory());

      expect(result, equals(0), reason: "$key should fail");
    });

    test('expect a positive match as matches minimum count', () {
      var key = "1-4 a: abc";
      var processor = newProcessor();
      processor.callback(key);
      var result = processor.valid(MaxMinFactory());

      expect(result, equals(1), reason: "$key should pass");
    });

    test('expect a positive match as in-between range maximum count', () {
      var key = "1-4 a: aabca";
      var processor = newProcessor();
      processor.callback(key);
      var result = processor.valid(MaxMinFactory());

      expect(result, equals(1), reason: "$key should pass");
    });

    test('expect a positive match as matches maximum count', () {
      var key = "1-4 a: aaabca";
      var processor = newProcessor();
      processor.callback(key);
      var result = processor.valid(MaxMinFactory());

      expect(result, equals(1), reason: "$key should pass");
    });
  });
}
