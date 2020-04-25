import 'package:covidtrack/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                kCOVIDImage,
                width: MediaQuery.of(context).size.width / 1.5,
                height: MediaQuery.of(context).size.height / 2,
              ),
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 2),
                child: Text(
                  'Stay Home',
                  style: TextStyle(
                      fontSize: 26,
                      fontFamily: 'Merienda',
                      fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                'Stay Safe',
                style: TextStyle(
                    fontSize: 26,
                    fontFamily: 'Merienda',
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green)),
            ],
          ),
        ));
  }
}
