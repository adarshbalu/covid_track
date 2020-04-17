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

final List<Color> yellow = [
  Colors.yellow[200],
  Colors.yellow[800],
];
final List<Color> purple = [Colors.deepPurpleAccent, Colors.deepPurple];
final List<Color> blue = [Colors.blue[200], Colors.blue[900]];
final List<Color> red = [Colors.redAccent, Colors.red];
final List<Color> green = [Colors.greenAccent, Colors.green];
final List<Color> white = [Colors.white10, Colors.white70];

final Map<String, List<Color>> colorArray = {
  'yellow': yellow,
  'purple': purple,
  'blue': blue,
  'red': red,
  'green': green,
  'white': white,
};

final types = {'cases': 'cases', 'recovered': 'recovered', 'deaths': 'deaths'};

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
