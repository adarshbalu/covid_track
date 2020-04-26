import 'package:covidtrack/utils/constants.dart';
import 'package:covidtrack/utils/models/country.dart';
import 'package:covidtrack/utils/models/state_data.dart';
import 'package:covidtrack/utils/models/state_list.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covidtrack/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountryPage extends StatefulWidget {
  final String countryName;
  final data;
  CountryPage({this.countryName, this.data});
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  CountryData countryData;
  String countryName;

  StateList stateList;
  List<StateData> stateDataList = List();

  @override
  void initState() {
    stateList = StateList(totalData: StateData());

    countryData = widget.data;
    countryName = widget.countryName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomMenu(),
      body: SafeArea(
        child: FutureBuilder(
            future: getCountry(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CountryNameHeader(snapshot.data.countryName,
                            snapshot.data.countryUrl),
                        Padding(
                          padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            elevation: 2,
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.fromLTRB(13, 13, 13, 13),
                              child: RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 19,
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                        text: snapshot.data.countryName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(text: ' has a total of '),
                                    TextSpan(
                                        text: snapshot.data.totalConfirmed
                                            .toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.deepPurple,
                                        )),
                                    TextSpan(
                                        text:
                                            ' cases , total recovered cases '),
                                    TextSpan(
                                        text: snapshot.data.totalRecovered
                                            .toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        )),
                                    TextSpan(text: ' at a recovery rate of '),
                                    TextSpan(
                                        text: ((countryData.totalRecovered /
                                                        countryData
                                                            .totalConfirmed) *
                                                    100)
                                                .toStringAsFixed(2) +
                                            '%',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green.shade800,
                                        )),
                                    TextSpan(text: ', total deaths '),
                                    TextSpan(
                                        text: snapshot.data.totalDeaths
                                            .toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        )),
                                    TextSpan(text: ' at a mortality rate of '),
                                    TextSpan(
                                        text: ((countryData.totalDeaths /
                                                        countryData
                                                            .totalConfirmed) *
                                                    100)
                                                .toStringAsFixed(2) +
                                            '%',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.redAccent,
                                        )),
                                    TextSpan(
                                        text:
                                            ' as per the latest data.\nCheck detailed Data Below'),
                                  ],
                                ),
                              ),
                            ),
                          ),
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
                          header: 'Total Confirmed',
                          totalCases: snapshot.data.totalConfirmed,
                          newCases: snapshot.data.newConfirmed,
                          color: Color(0xff4a148c),
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
                      ],
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

  Future<CountryData> getCountry() async {
    countryData.getCountryData(widget.data);
    return countryData;
  }
}
