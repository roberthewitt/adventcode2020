import '../utils.dart';

mixin PasswordChecker {
  bool isValid(String password);
}

mixin PasswordCheckerFactory {
  PasswordChecker build(String code);
}

class Processor {
  Function(String line) callback;
  int Function(PasswordCheckerFactory factory) valid;
}

Processor newProcessor() {
  List<String> lines = [];
  var processor = Processor();

  String getPassword(String text) => text.split(":")[1].trim();

  processor.callback = lines.add;
  processor.valid = (factory) =>
      lines.where((v) => factory.build(v).isValid(getPassword(v))).length;

  return processor;
}

void main() {
  var processor = newProcessor();

  readFileByLine("data/day2.txt", processor.callback, onComplete: () {
    print('pt1 passwords that work: ${processor.valid(MaxMinFactory())}');
    print('pt2 passwords that work: ${processor.valid(PositionFactory())}');
  });
}

class MaxMinRule with PasswordChecker {
  String character;
  int minimum, maximum;

  @override
  bool isValid(String password) {
    var count = password.split('').where((e) => e == character).length;
    var valid = count >= minimum && count <= maximum;
    return valid;
  }
}

class PositionRule with PasswordChecker {
  String character;
  List<int> atPosition;

  @override
  bool isValid(String password) =>
      atPosition
          .map((e) => e - 1)
          .map((e) => password.split("")[e])
          .where((char) => char == character)
          .length ==
      1;
}

class MaxMinFactory with PasswordCheckerFactory {
  @override
  PasswordChecker build(String text) {
    var rule = new MaxMinRule();

    var ruleText = text.split(":")[0];
    var bits = ruleText.split(" ");

    rule.character = bits[1].trim();
    var tolerances = bits[0].split("-");
    rule.maximum = int.parse(tolerances[1]);
    rule.minimum = int.parse(tolerances[0]);

    return rule;
  }
}

class PositionFactory with PasswordCheckerFactory {
  @override
  PasswordChecker build(String text) {
    var rule = PositionRule();
    var ruleText = text.split(":")[0];
    var bits = ruleText.split(" ");

    rule.character = bits[1].trim();
    var tolerances = bits[0].split("-");
    rule.atPosition = [
      int.parse(tolerances[0]),
      int.parse(tolerances[1]),
    ];

    return rule;
  }
}
