import 'package:covidtrack/screens/home_page.dart';
import 'package:flutter/material.dart';

final monthNames = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
];

const kHeaderTextStyle = TextStyle(fontSize: 40, fontWeight: FontWeight.w900);

const kSickImage = 'assets/sick.png';

const kGermImage = 'assets/germ.png';

const kSanitizerImage = 'assets/handsanitizer.png';
const kHandWashImage = 'assets/handwash.png';

const kSecondaryTextStyle =
    TextStyle(fontWeight: FontWeight.w700, fontSize: 25);

const kCaseNameTextStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

const kSecondaryTextStyleWhite = TextStyle(color: Colors.white, fontSize: 30);

const kLastUpdatedTextStyle = TextStyle(color: Colors.grey, fontSize: 15);

const kPrimaryTextStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.w300);

void toCountrySelectPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return HomePage();
  }));
}
