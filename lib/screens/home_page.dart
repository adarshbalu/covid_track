import 'package:covidtrack/screens/start_screen.dart';
import 'package:covidtrack/screens/stat_detail_page.dart';
import 'package:covidtrack/screens/stats_page.dart';
import 'package:covidtrack/utils/constants.dart';
import 'package:covidtrack/utils/models/country.dart';
import 'package:covidtrack/utils/models/global.dart';
import 'package:covidtrack/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalData globalData;
  DateTime dateTime = DateTime.now();
  String date = '';
  bool load = false, showAll = true, showNew = true, showStats = true;
  var allCountryArray;
  IconData showAllIcon, showNewIcon, showStatsIcon;
  CountryData mostCases, mostDeaths, mostRecovered;

  @override
  void initState() {
    date = dateTime.day.toString() +
        ' ' +
        monthNames[dateTime.month - 1] +
        ' ' +
        dateTime.year.toString();
    globalData = GlobalData();
    showStatsIcon = showNewIcon = showAllIcon = Icons.expand_less;
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
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 0),
                                child: Text(
                                  'All Cases',
                                  style: TextStyle(
                                      fontSize: 35,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Merienda'),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    showAll = !showAll;
                                    if (showAll)
                                      showAllIcon = Icons.expand_less;
                                    else
                                      showAllIcon = Icons.expand_more;
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Icon(
                                      showAllIcon,
                                      size: 35,
                                    )),
                              )
                            ],
                          ),
                          showAll
                              ? Column(
                                  children: <Widget>[
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
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(8, 10, 8, 10),
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          elevation: 2,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            padding: EdgeInsets.fromLTRB(
                                                8, 13, 8, 13),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                PercentDataCard(
                                                  title: 'Active',
                                                  number: ((globalData
                                                                  .totalActive /
                                                              globalData
                                                                  .totalConfirmed) *
                                                          100)
                                                      .toStringAsFixed(2),
                                                  color: Colors.deepPurple,
                                                ),
                                                Divider(),
                                                PercentDataCard(
                                                  title: 'Recovered',
                                                  number: ((globalData
                                                                  .totalRecovered /
                                                              globalData
                                                                  .totalConfirmed) *
                                                          100)
                                                      .toStringAsFixed(2),
                                                  color: Colors.green,
                                                ),
                                                Divider(),
                                                PercentDataCard(
                                                  title: 'Death',
                                                  number: ((globalData
                                                                  .totalDeaths /
                                                              globalData
                                                                  .totalConfirmed) *
                                                          100)
                                                      .toStringAsFixed(2),
                                                  color: Colors.red,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.9,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      width: MediaQuery.of(context).size.width /
                                          1.3,
                                      margin:
                                          EdgeInsets.only(top: 8, bottom: 15),
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
                                  ],
                                )
                              : SizedBox(),
                          Divider(),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 0),
                                child: Text(
                                  'New Cases',
                                  style: TextStyle(
                                      fontSize: 35,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Merienda'),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    showNew = !showNew;
                                    if (showNew)
                                      showNewIcon = Icons.expand_less;
                                    else
                                      showNewIcon = Icons.expand_more;
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Icon(
                                      showNewIcon,
                                      size: 35,
                                    )),
                              )
                            ],
                          ),
                          showNew
                              ? Column(
                                  children: <Widget>[
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
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(8, 10, 8, 10),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(10),
                                        elevation: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          padding:
                                              EdgeInsets.fromLTRB(8, 13, 8, 13),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              PercentDataCard(
                                                title: 'New Active',
                                                number: ((globalData
                                                                .newConfirmed /
                                                            globalData
                                                                .totalConfirmed) *
                                                        100)
                                                    .toStringAsFixed(2),
                                                color: Colors.deepPurple,
                                              ),
                                              Divider(),
                                              PercentDataCard(
                                                title: 'New Recovered',
                                                number: ((globalData
                                                                .newRecovered /
                                                            globalData
                                                                .totalConfirmed) *
                                                        100)
                                                    .toStringAsFixed(2),
                                                color: Colors.green,
                                              ),
                                              Divider(),
                                              PercentDataCard(
                                                title: 'New Death',
                                                number: ((globalData.newDeaths /
                                                            globalData
                                                                .totalDeaths) *
                                                        100)
                                                    .toStringAsFixed(2),
                                                color: Colors.red,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.2,
                                        margin:
                                            EdgeInsets.only(top: 8, bottom: 15),
                                        padding: EdgeInsets.all(18),
                                        child: Column(
                                          children: <Widget>[
                                            Text('New Cases'),
                                            Expanded(
                                              child: BarChart([
                                                Case(
                                                    type: 'Confirmed',
                                                    value: snapshot
                                                        .data.newConfirmed,
                                                    barColor: charts.ColorUtil
                                                        .fromDartColor(
                                                            Colors.deepPurple)),
                                                Case(
                                                    type: 'Recovered',
                                                    value: snapshot
                                                        .data.newRecovered,
                                                    barColor: charts.ColorUtil
                                                        .fromDartColor(
                                                            Colors.green)),
                                                Case(
                                                    type: 'Death',
                                                    value:
                                                        snapshot.data.newDeaths,
                                                    barColor: charts.ColorUtil
                                                        .fromDartColor(
                                                            Colors.red)),
                                              ]),
                                            ),
                                          ],
                                        )),
                                  ],
                                )
                              : SizedBox(),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: Text(
                              'Statistics',
                              style: TextStyle(
                                  fontSize: 35,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Merienda'),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                showStats = !showStats;
                                if (showStats)
                                  showStatsIcon = Icons.expand_less;
                                else
                                  showStatsIcon = Icons.expand_more;
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: Icon(
                                  showStatsIcon,
                                  size: 35,
                                )),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      showStats
                          ? StatsPage()
                          : SizedBox(
                              height: 40,
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          Text(
                            ' Stay Home , Stay Safe',
                            style: TextStyle(fontFamily: 'Poppins'),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
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
    }
    setState(() {
      load = true;
    });
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
