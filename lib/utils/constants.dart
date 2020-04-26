import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

final types = {'cases': 'cases', 'recovered': 'recovered', 'deaths': 'deaths'};

//Colors

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

// Text Styles

const kHeaderTextStyle = TextStyle(
    fontSize: 38, fontWeight: FontWeight.w600, fontFamily: 'Merienda');

const kSecondaryTextStyle =
    TextStyle(fontWeight: FontWeight.w700, fontSize: 25);

const kCaseNameTextStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

const kSecondaryTextStyleWhite = TextStyle(color: Colors.white, fontSize: 29);

const kLastUpdatedTextStyle = TextStyle(color: Colors.grey, fontSize: 15);

const kPrimaryTextStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.w300);
const kTertiaryTextStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w300);
// Images

const kAvoidTouchImage = 'assets/avoid-touch.png';
const kCoughImage = 'assets/cough.png';
const kCOVIDImage = 'assets/covid-19.png';
const kDifficultyBreathingImage = 'assets/difficulty-breathing.png';
const kFeverImage = 'assets/fever.png';
const kGermImage = 'assets/germ.png';
const kHandWashImage = 'assets/hand-wash.png';
const kIndiaImage = 'assets/india.png';
const kKeepDistanceImage = 'assets/keep-distance.png';
const kMaskImage = 'assets/mask.png';
const kPandemic_1_Image = 'assets/pandemic-1.png';
const kPandemic_2_Image = 'assets/pandemic-2.png';
const kRunnyNoseImage = 'assets/runny-nose.png';
const kSickImage = 'assets/sick.png';
const kSoreThroatImage = 'assets/sore-throat.png';
const kStayHomeImage = 'assets/stay-home.png';
const kTissueImage = 'assets/tissue.png';

var random = Random();

var formatter = NumberFormat("##,##,##,###");

const kBackgroundColor = Color(0xFFFEFEFE);
const kTitleTextColor = Color(0xFF303030);
const kBodyTextColor = Color(0xFF4B4B4B);
const kTextLightColor = Color(0xFF959595);
const kInfectedColor = Color(0xFFFF8748);
const kDeathColor = Color(0xFFFF4848);
const kRecovercolor = Color(0xFF36C12C);
const kPrimaryColor = Color(0xFF3382CC);
final kShadowColor = Color(0xFFB7B7B7).withOpacity(.16);
final kActiveShadowColor = Color(0xFF4056C6).withOpacity(.15);

// Text Style
const kHeadingTextStyle =
    TextStyle(fontSize: 22, fontWeight: FontWeight.w600, fontFamily: 'Poppins');

const kSubTextStyle =
    TextStyle(fontSize: 16, color: kTextLightColor, fontFamily: 'Poppins');

const kTitleTextstyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 18,
  color: kTitleTextColor,
  fontWeight: FontWeight.bold,
);
