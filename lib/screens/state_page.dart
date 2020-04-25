import 'package:covidtrack/screens/district_detail.dart';
import 'package:covidtrack/utils/constants.dart';
import 'package:covidtrack/utils/models/state_data.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covidtrack/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatePage extends StatefulWidget {
  final String stateName;
  final data;
  StatePage({this.stateName, this.data});
  @override
  _StatePageState createState() => _StatePageState();
}

class _StatePageState extends State<StatePage> {
  StateData stateData;
  String stateName;

  @override
  void initState() {
    stateData = widget.data;
    stateName = widget.stateName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomMenu(),
      body: SafeArea(
        child: FutureBuilder(
            future: getStateData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(5),
                                bottomLeft: Radius.circular(5)),
                          ),
                          padding: EdgeInsets.only(
                              left: 10, right: 8, top: 0, bottom: 8),
                          margin: EdgeInsets.only(bottom: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                kIndiaImage,
                                width: 35,
                              ),
                              Text(
                                stateName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 25,
                                    fontFamily: 'Merienda'),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0, bottom: 0),
                          child: Text(
                            'Total Data',
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Merienda'),
                          ),
                        ),
                        CountryDataCard(
                          header: 'Total Confirmed',
                          totalCases: snapshot.data.totalConfirmed,
                          newCases: snapshot.data.newConfirmed,
                          color: Color(0xff4a148c),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 2.2,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          width: MediaQuery.of(context).size.width / 1.3,
                          margin: EdgeInsets.only(top: 8, bottom: 15),
                          padding: EdgeInsets.all(8),
                          child: PieChart([
                            Case(
                                type: 'Active',
                                value: snapshot.data.totalActive,
                                colorValue: Color(0xff2962ff)),
                            Case(
                                type: 'Recovered',
                                value: snapshot.data.totalRecovered,
                                colorValue: Color(0xff4caf50)),
                            Case(
                                type: 'Death',
                                value: snapshot.data.totalDeaths,
                                colorValue: Color(0xffff1744)),
                          ], true),
                        ),
                        CountryDataCard(
                          header: 'Total Active',
                          totalCases: snapshot.data.totalActive,
                          newCases: snapshot.data.newActive,
                          color: Color(0xff2962ff),
                        ),
                        CountryDataCard(
                          header: 'Total Recovered',
                          totalCases: snapshot.data.totalRecovered,
                          newCases: snapshot.data.newRecovered,
                          color: Color(0xff4caf50),
                        ),
                        CountryDataCard(
                          header: 'Total Deaths',
                          totalCases: snapshot.data.totalDeaths,
                          newCases: snapshot.data.newDeaths,
                          color: Color(0xffff1744),
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
                                Text(
                                  'New Cases',
                                  style: kPrimaryTextStyle,
                                ),
                                Expanded(
                                  child: BarChart(
                                    [
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
                                    ],
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 8,
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0, bottom: 8),
                          child: Text(
                            'District Data',
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Merienda'),
                          ),
                        ),
                      ],
                    ),
                    DistrictDetails(snapshot.data.name),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                );
              } else {
                return ErrorScreen();
              }
            }),
      ),
    );
  }

  Future<StateData> getStateData() async {
    stateData.setStateData(widget.data);
    return stateData;
  }
}
