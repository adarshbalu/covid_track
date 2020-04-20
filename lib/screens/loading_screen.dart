import 'package:covidtrack/utils/constants.dart';
import 'package:flutter/material.dart';
class LoaderScreen extends StatelessWidget {
  final String text1, text2, image;
  final Function onTap;
  LoaderScreen({this.text1, this.text2, this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height / 3.5,
        ),
        Image.asset(
          image,
          width: 80,
          height: 80,
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: Text(
            text1,
            style: kSecondaryTextStyle,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: Text(
            text2,
            style: kCaseNameTextStyle,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.transparent,
          ),
        ),
      ],
    );
  }
}