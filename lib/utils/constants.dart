import 'dart:math';

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

const kSecondaryTextStyleWhite = TextStyle(color: Colors.white, fontSize: 30);

const kLastUpdatedTextStyle = TextStyle(color: Colors.grey, fontSize: 15);

const kPrimaryTextStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.w300);

// Images

const kAvoidEyeImage = 'assets/avoid-eye.png';
const kAvoidGathering_1_Image = 'assets/avoid-gathering-1.png';
const kAvoidGathering_2_Image = 'assets/avoid-gathering-2.png';
const kAvoidMouthImage = 'assets/avoid-mouth.png';
const kAvoidNoseImage = 'assets/avoid-nose.png';
const kAvoidTravelImage = 'assets/avoid-travel.png';
const kCleanImage = 'assets/clean.png';
const kCoughImage = 'assets/cough.png';
const kCOVIDImage = 'assets/covid-19.png';
const kDifficultyBreathingImage = 'assets/difficulty-breathing.png';
const kDisinfectImage = 'assets/disinfect.png';
const kFeverImage = 'assets/fever.png';
const kGermImage = 'assets/germ.png';
const kGloveImage = 'assets/gloves.png';
const kGraphImage = 'assets/graph.png';
const kHandImage = 'assets/hand.png';
const kHandWash_1_Image = 'assets/hand-wash-1.png';
const kHandWash_2_Image = 'assets/hand-wash-2.png';
const kSanitizerImage = 'assets/handsanitizer.png';
const kHandWashImage = 'assets/handwash.png';
const kIndiaImage = 'assets/india.png';
const kKeepDistanceImage = 'assets/keep-distance.png';
const kMask_1_Image = 'assets/mask-1.png';
const kMask_2_Image = 'assets/mask-2.png';
const kMask_3_Image = 'assets/mask-3.png';
const kMask_4_Image = 'assets/mask-4.png';
const kMedicalMaskImage = 'assets/medical-mask.png';
const kMedicineImage = 'assets/medicine.png';
const kPandemic_1_Image = 'assets/pandemic-1.png';
const kPandemic_2_Image = 'assets/pandemic-2.png';
const kPillsImage = 'assets/pills.png';
const kQuarantineImage = 'assets/quarantine.png';
const kRunnyNoseImage = 'assets/runny-nose.png';
const kSickImage = 'assets/sick.png';
const kSoreThroatImage = 'assets/sore-throat.png';
const kStayHomeImage = 'assets/stay-home.png';
const kTissueImage = 'assets/tissue.png';
const kVaccine_1_Image = 'assets/vaccine-1.png';
const kVaccine_2_Image = 'assets/vaccine-2.png';
const kVirus_1_Image = 'assets/vaccine-1.png';
const kVirus_2_Image = 'assets/vaccine-2.png';

var random = Random();
