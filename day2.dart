import 'utils.dart';

mixin PasswordChecker {
  bool isValid(String password);
}

class MaxMinRule with PasswordChecker {
  String character;
  int minimum;
  int maximum;

  @override
  String toString() => 'PasswordRule($minimum-$maximum $character)';

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
  String toString() => 'PositionRule($atPosition $character)';

  @override
  bool isValid(String password) {
    var array = password.split("");
    return atPosition
            .map((e) => e - 1)
            .map((e) => array[e])
            .where((char) => char == character)
            .length ==
        1;
  }
}

void main() {
  List<String> passes = [];

  readFileByLine("inputData_day2.txt", (element) {
    var rule = getPositionRule(element);
    var password = getPassword(element);

    if (passesRules(password, [rule])) {
      passes.add(password);
    }
  }, onComplete: () {
    print('passwords that work: ${passes.length}');
  });
}

MaxMinRule getMaxMinRule(String text) {
  var rule = new MaxMinRule();

  var ruleText = text.split(":")[0];
  var bits = ruleText.split(" ");

  rule.character = bits[1].trim();
  var tolerances = bits[0].split("-");
  rule.maximum = int.parse(tolerances[1]);
  rule.minimum = int.parse(tolerances[0]);

  return rule;
}

PositionRule getPositionRule(String text) {
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

String getPassword(String text) => text.split(":")[1].trim();

bool passesRules(String text, List<PasswordChecker> rules) =>
    rules.where((rule) => !rule.isValid(text)).length == 0;
