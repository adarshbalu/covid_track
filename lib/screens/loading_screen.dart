import 'package:covidtrack/utils/widgets.dart';
import 'package:flutter/material.dart';

class LoaderScreen extends StatelessWidget {
  final String text, image;

  LoaderScreen({
    this.text,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          AppHeader(
            headerText: 'Advices',
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Container(
                margin: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width / 1.5,
                height: MediaQuery.of(context).size.height / 4,
                child: Image.asset(
                  image,
                  width: 80,
                  height: 80,
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding:
                    EdgeInsets.only(top: 30, left: 10.0, right: 10, bottom: 8),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 23,
                      fontFamily: 'Merienda',
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.transparent,
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
