import 'dart:math';

import 'utils.dart';

const BirthYear = "byr";
const IssueYear = "iyr";
const ExpirationYear = "eyr";
const Height = "hgt";
const HairColor = "hcl";
const EyeColor = "ecl";
const PassportID = "pid";
const CountryID =  "cid";

const requiredFields = [
  BirthYear,
  IssueYear,
  ExpirationYear,
  Height,
  HairColor,
  EyeColor,
  PassportID,
];





main() {
  readFileByLine("inputData_day3.txt", (line) {
  }, onComplete: () {

    print('valid passports: ');
  });
}
