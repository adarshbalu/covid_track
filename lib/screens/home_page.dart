import 'dart:convert';
import 'package:covidtrack/screens/country_select_page.dart';
import 'package:covidtrack/screens/stat_detail_page.dart';
import 'package:covidtrack/utils/constants.dart';
import 'package:covidtrack/utils/global_data_model.dart';
import 'package:covidtrack/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalData globalData;
  DateTime dateTime = DateTime.now();
  String date = '';
  bool load = false;
  var allCountryArray;
  @override
  void initState() {
    date = dateTime.day.toString() +
        ' ' +
        monthNames[dateTime.month - 1] +
        ' ' +
        dateTime.year.toString();
    globalData = GlobalData(
        totalActive: 0,
        totalConfirmed: 0,
        totalDeath: 0,
        totalRecovered: 0,
        newActive: 0,
        newDeaths: 0,
        newConfirmed: 0,
        newRecovered: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomMenu(allCountryArray),
      body: SafeArea(
        child: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        AppHeader(
                          headerText: 'COVID-19',
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        CaseCard(
                          totalCases: snapshot.data.totalConfirmed,
                          isFlag: false,
                          color: colorArray['purple'],
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
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.none ||
                  snapshot.hasError) {
                return LoaderScreen(
                  text1: 'Some Issue Connecting',
                  text2: 'Please check network',
                  image: kSanitizerImage,
                );
              } else {
                return LoaderScreen(
                  text1: 'Wash your hands with Soap',
                  text2: 'While we sync data for you  .. ',
                  image: kHandWashImage,
                );
              }
            }),
      ),
    );
  }

  void toCountrySelectPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CountrySelectPage();
    }));
  }

  Future<GlobalData> getData() async {
    if (!load) {
      http.Response response =
          await http.get('https://api.covid19api.com/summary');
      if (response.statusCode == 200) {
        var data = response.body;
        setState(() {
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
          globalData.newActive = globalData.newConfirmed -
              (globalData.newRecovered + globalData.newDeaths);
          allCountryArray = jsonDecode(data)['Countries'];
        });
      }
      load = true;
    }
    return globalData;
  }

  void toScreen(BuildContext context, String type, var data) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return StatDetail(
        type: type,
        data: data,
      );
    }));
  }
}
