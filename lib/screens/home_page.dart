import 'dart:convert';
import 'package:covidtrack/utils/constants.dart';
import 'package:covidtrack/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalData globalData;

  @override
  void initState() {
    globalData = GlobalData(
      totalActive: 0,
      totalConfirmed: 0,
      totalDeath: 0,
      totalRecovered: 0,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    AppHeader(),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'World Outbreak',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
                    ),
                    CaseCard(
                      totalCases: snapshot.data.totalConfirmed,
                    ),
                    DataListTile(
                      color: Colors.deepPurple,
                      cases: snapshot.data.totalActive,
                      text: 'Active',
                    ),
                    DataListTile(
                      color: Colors.green,
                      cases: snapshot.data.totalRecovered,
                      text: 'Recovered',
                    ),
                    DataListTile(
                      color: Colors.red,
                      cases: snapshot.data.totalDeath,
                      text: 'Deaths',
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Last Updated Today',
                        style: kLastUpdatedTextStyle,
                      ),
                    ),
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.none ||
                  snapshot.hasError) {
                return OtherScreen(
                  text1: 'Some Issue Connecting',
                  text2: 'Please check network',
                  image: kSanitizerImage,
                );
              } else {
                return OtherScreen(
                  text1: 'Wash your hands with Soap',
                  text2: 'While we sync data for you  .. ',
                  image: kHandWashImage,
                );
              }
            }),
      ),
    );
  }

  Future<GlobalData> getData() async {
    http.Response response =
        await http.get('https://api.covid19api.com/summary');
    if (response.statusCode == 200) {
      setState(() {
        var data = response.body;
        globalData.totalRecovered =
            jsonDecode(data)['Global']['TotalRecovered'];
        globalData.totalDeath = jsonDecode(data)['Global']['TotalDeaths'];
        globalData.totalConfirmed =
            jsonDecode(data)['Global']['TotalConfirmed'];
        globalData.newConfirmed = jsonDecode(data)['Global']['NewConfirmed'];
        globalData.newDeaths = jsonDecode(data)['Global']['NewDeaths'];
        globalData.newRecovered = jsonDecode(data)['Global']['NewRecovered'];
        globalData.totalActive = globalData.totalConfirmed -
            (globalData.totalRecovered + globalData.totalDeath);
      });
    }
    return globalData;
  }
}

class GlobalData {
  int totalConfirmed,
      totalRecovered,
      totalDeath,
      totalActive,
      newConfirmed,
      newDeaths,
      newRecovered;

  GlobalData({
    this.totalConfirmed,
    this.totalDeath,
    this.totalRecovered,
    this.totalActive,
  });
}
