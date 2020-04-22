import 'dart:math';

import 'package:covidtrack/utils/constants.dart';
import 'package:covidtrack/utils/models/content.dart';

class ContentsList {
  List<Content> contents = List();
  Content content;
  getAllContents() {
    Content _content = Content();
    this.contents.add(_content.getContent(_avoidTouching, kAvoidNoseImage));
    this.contents.add(_content.getContent(_avoidTouching, kAvoidMouthImage));
    this.contents.add(_content.getContent(_avoidTouching, kAvoidEyeImage));
    this.contents.add(_content.getContent(_avoidTravel, kAvoidTravelImage));
    this
        .contents
        .add(_content.getContent(_socialDistancing, kKeepDistanceImage));
    this
        .contents
        .add(_content.getContent(_socialDistancing, kAvoidGathering_1_Image));
    this.contents.add(_content.getContent(_symptoms, kCoughImage));
    this
        .contents
        .add(_content.getContent(_symptoms, kDifficultyBreathingImage));
    this.contents.add(_content.getContent(_symptoms, kFeverImage));
    this.contents.add(_content.getContent(_symptoms, kRunnyNoseImage));
    this.contents.add(_content.getContent(_symptoms, kSoreThroatImage));
    this.contents.add(_content.getContent(_stayHome, kStayHomeImage));
    this.contents.add(_content.getContent(_wash, kSanitizerImage));
    this.contents.add(_content.getContent(_wash, kHandWashImage));
    this.contents.add(_content.getContent(_wash, kHandWash_1_Image));
    this.contents.add(_content.getContent(_wash, kHandWash_2_Image));
    this.contents.add(_content.getContent(_mask, kMask_1_Image));
    this.contents.add(_content.getContent(_mask, kMask_2_Image));
    this.contents.add(_content.getContent(_mask, kMask_3_Image));
    this.contents.add(_content.getContent(_mask, kMask_4_Image));
    this.contents.add(_content.getContent(_respiratoryHygiene, kTissueImage));
    this.contents.add(_content.getContent(_quarantine, kQuarantineImage));
    this
        .contents
        .add(_content.getContent(_quarantine, kAvoidGathering_2_Image));
    this.contents.add(_content.getContent(_clean, kCleanImage));
    return this.contents;
  }

  String _avoidTouching =
      'Avoid touching eyes, nose and mouth.Hands touch many surfaces and can pick up viruses';
  String _avoidTravel = 'Avoid Travelling to other countries';
  String _socialDistancing =
      'Maintain at least 1 metre (3 feet) distance between yourself and anyone who is coughing or sneezing.';
  String _symptoms =
      'If you have a fever, cough and difficulty breathing, seek medical attention and call in advance. Follow the directions of your local health authority.';

  String _stayHome =
      'Stay informed and follow advice given by your healthcare provider';
  String _wash =
      'Wash your hands frequently and thoroughly with an alcohol-based hand rub or wash them with soap and water.';
  String _mask =
      'Wear masks when going out and dispose them properly after use.';
  String _respiratoryHygiene =
      'Cover your mouth and nose with your bent elbow or tissue when you cough or sneeze. Then dispose of the used tissue immediately.';
  String _quarantine =
      'If adviced to be in quarantine , complete the quarantine period to avoid potential spread .';
  String _clean = 'Clean house and surroundings with soap and water.';
}
