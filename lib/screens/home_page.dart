import 'package:covidtrack/screens/country_select_page.dart';
import 'package:covidtrack/screens/stat_detail_page.dart';
import 'package:covidtrack/utils/constants.dart';
import 'package:covidtrack/utils/models/global.dart';
import 'package:covidtrack/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

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
    globalData = GlobalData();
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
                          cases: snapshot.data.totalDeaths,
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
      await globalData.getGlobalData();
      setState(() {
        load = true;
      });
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
