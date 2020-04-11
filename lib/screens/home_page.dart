import 'package:covidtrack/utils/constants.dart';
import 'package:covidtrack/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AppHeader(),
            SizedBox(
              height: 15,
            ),
            Text(
              'World Outbreak',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
            ),
            CaseCard(),
            DataListTile(
              color: Colors.deepPurple,
              cases: 80677,
              text: 'Active',
            ),
            DataListTile(
              color: Colors.green,
              cases: 16765,
              text: 'Recovered',
            ),
            DataListTile(
              color: Colors.red,
              cases: 13272,
              text: 'Deaths',
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                'Last Updated on 10 March 2020',
                style: kLastUpdatedTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
