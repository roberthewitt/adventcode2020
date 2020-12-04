import 'utils.dart';

const BirthYear = "byr";
const IssueYear = "iyr";
const ExpirationYear = "eyr";
const Height = "hgt";
const HairColor = "hcl";
const EyeColor = "ecl";
const PassportID = "pid";
const CountryID = "cid";

mixin RuleProcessor {
  bool isValid(String value);
}

class AlwaysPasses with RuleProcessor {
  @override
  bool isValid(String) => true;
}

var alwaysPasses = new AlwaysPasses();

RuleProcessor processorFor(String key) {
  var processors = {
    BirthYear: new BirthYearProcessor(),
    IssueYear: new IssueYearProcessor(),
    ExpirationYear: new ExpirationYearProcessor(),
  };
  return processors[key] ?? alwaysPasses;
}

class BirthYearProcessor with RuleProcessor {
  @override
  bool isValid(String value) {
    if (value.length != 4)  return false;

    var asInt = int.parse(value);
    if (asInt < 1920) return false;
    if (asInt > 2002) return false;

    return true;
  }
}

class IssueYearProcessor with RuleProcessor {
  @override
  bool isValid(String value) {
    if (value.length != 4)  return false;

    var asInt = int.parse(value);
    if (asInt < 2010) return false;
    if (asInt > 2020) return false;

    return true;
  }
}

class ExpirationYearProcessor with RuleProcessor {
  @override
  bool isValid(String value) {
    if (value.length != 4)  return false;

    var asInt = int.parse(value);
    if (asInt < 2020) return false;
    if (asInt > 2030) return false;

    return true;
  }
}

const requiredFields = [
  BirthYear,
  IssueYear,
  ExpirationYear,
  Height,
  HairColor,
  EyeColor,
  PassportID,
];

class PassportData {
  Map<String, String> data = {};
  List<String> missingFields = [...requiredFields];

  bool get isValid => missingFields.length == 0;
}

class PassportInfo {
  List<PassportData> items = [new PassportData()];

  int get validCount => items.where((a) => a.isValid).length;

  int get totalCount => items.length;
}

class Output {
  Function(String) callback;
  PassportInfo info;
}

Output newProcessor() {
  var output = new Output();
  output.info = new PassportInfo();
  output.callback = (line) {
    var trimmedLine = line.trim();
    if (trimmedLine.isEmpty) {
      output.info.items.add(new PassportData());
    } else {
      var args = trimmedLine.split(" ");
      var passport = output.info.items.last;
      args.map((e) => e.split(":")).map((e) => {e[0]: e[1]}).forEach((data) {
        passport.data.addAll(data);
      });
      passport.missingFields.removeWhere((key) {
        if (passport.data.containsKey(key)) {
          return processorFor(key).isValid(passport.data[key]);
        }
        return false;
      });
    }
  };
  return output;
}

main() {
  var output = newProcessor();
  readFileByLine("inputData_day4.txt", output.callback, onComplete: () {
    print('all passports: ${output.info.totalCount}');
    print('valid passports: ${output.info.validCount}');
  });
}
