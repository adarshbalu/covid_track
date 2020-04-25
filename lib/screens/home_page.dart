import 'package:covidtrack/screens/start_screen.dart';
import 'package:covidtrack/screens/stat_detail_page.dart';
import 'package:covidtrack/utils/constants.dart';
import 'package:covidtrack/utils/models/global.dart';
import 'package:covidtrack/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HomePage extends StatefulWidget {
  final data;
  HomePage(this.data);
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
      bottomNavigationBar: BottomMenu(),
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: SafeArea(
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
                            height: 8,
                          ),
                          CaseCard(
                            totalCases: snapshot.data.totalConfirmed,
                            isFlag: false,
                            color: colorArray['purple'],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              'All Cases',
                              style: TextStyle(
                                  fontSize: 35,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Merienda'),
                            ),
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
                            cases: globalData.totalDeaths,
                            text: 'Deaths',
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 1.9,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            width: MediaQuery.of(context).size.width / 1.3,
                            margin: EdgeInsets.only(top: 8, bottom: 15),
                            padding: EdgeInsets.all(8),
                            child: PieChart([
                              Case(
                                  type: 'Active',
                                  value: globalData.totalActive,
                                  colorValue: Color(0xff311b92),
                                  barColor: null),
                              Case(
                                  type: 'Recovered',
                                  value: globalData.totalRecovered,
                                  colorValue: Color(0xff4caf50),
                                  barColor: null),
                              Case(
                                  type: 'Death',
                                  value: globalData.totalDeaths,
                                  colorValue: Color(0xffff1744),
                                  barColor: null),
                            ], false),
                          ),
                          Divider(),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 8),
                            child: Text(
                              'New Cases',
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Merienda'),
                            ),
                          ),
                          DataListTile(
                            color: Colors.deepPurple,
                            cases: snapshot.data.newConfirmed,
                            text: 'Confirmed',
                          ),
                          DataListTile(
                            color: Colors.green,
                            cases: snapshot.data.newRecovered,
                            text: 'Recovered',
                          ),
                          DataListTile(
                            color: Colors.red,
                            cases: snapshot.data.newDeaths,
                            text: 'Deaths',
                          ),
                          Container(
                              height: MediaQuery.of(context).size.height / 2,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              width: MediaQuery.of(context).size.width / 1.2,
                              margin: EdgeInsets.only(top: 8, bottom: 15),
                              padding: EdgeInsets.all(18),
                              child: Column(
                                children: <Widget>[
                                  Text('New Cases'),
                                  Expanded(
                                    child: BarChart([
                                      Case(
                                          type: 'Confirmed',
                                          value: snapshot.data.newConfirmed,
                                          barColor:
                                              charts.ColorUtil.fromDartColor(
                                                  Colors.deepPurple)),
                                      Case(
                                          type: 'Recovered',
                                          value: snapshot.data.newRecovered,
                                          barColor:
                                              charts.ColorUtil.fromDartColor(
                                                  Colors.green)),
                                      Case(
                                          type: 'Death',
                                          value: snapshot.data.newDeaths,
                                          barColor:
                                              charts.ColorUtil.fromDartColor(
                                                  Colors.red)),
                                    ]),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ],
                  );
                } else if (snapshot.connectionState == ConnectionState.none ||
                    snapshot.hasError) {
                  return ErrorScreen();
                } else {
                  return StartScreen();
                }
              }),
        ),
      ),
    );
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
