import 'dart:convert';
import 'package:covidtrack/utils/constants.dart';
import 'package:covidtrack/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
              if (!(snapshot.connectionState == ConnectionState.waiting)) {
                print(globalData.date);
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
                      totalCases: globalData.totalConfirmed,
                    ),
                    DataListTile(
                      color: Colors.deepPurple,
                      cases: globalData.totalActive,
                      text: 'Active',
                    ),
                    DataListTile(
                      color: Colors.green,
                      cases: globalData.totalRecovered,
                      text: 'Recovered',
                    ),
                    DataListTile(
                      color: Colors.red,
                      cases: globalData.totalDeath,
                      text: 'Deaths',
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Last Updated on + $globalData.date',
                        style: kLastUpdatedTextStyle,
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    AppHeader(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2.7,
                    ),
                    Center(
                      child: Text(
                        'Wash your hands with Soap',
                        style: kCaseNumberTextStyle,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Text(
                        'While we sync data for you  .. ',
                        style: kCaseNameTextStyle,
                      ),
                    ),
                  ],
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
        globalData.totalActive = globalData.totalConfirmed -
            (globalData.totalRecovered + globalData.totalDeath);
        globalData.date = DateTime.now();
      });
    }
    return globalData;
  }
}

class GlobalData {
  int totalConfirmed, totalRecovered, totalDeath, totalActive;
  DateTime date;

  GlobalData(
      {this.totalConfirmed,
      this.totalDeath,
      this.totalRecovered,
      this.totalActive,
      this.date});
}
