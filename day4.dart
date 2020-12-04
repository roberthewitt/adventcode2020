import 'utils.dart';

const BirthYear = "byr";
const IssueYear = "iyr";
const ExpirationYear = "eyr";
const Height = "hgt";
const HairColor = "hcl";
const EyeColor = "ecl";
const PassportID = "pid";
const CountryID = "cid";

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
  bool isValid = false;
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
    if (line.trim().isEmpty) {
      output.info.items.add(new PassportData());
    } else {
      var args = line.split(" ");
      var passport = output.info.items.last;
      args.map((e) => e.split(":")).map((e) => {e[0]: e[1]}).forEach((data) {
        passport.data.addAll(data);
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
