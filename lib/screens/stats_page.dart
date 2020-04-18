import 'dart:convert';

import 'package:covidtrack/screens/stat_detail_page.dart';
import 'package:covidtrack/utils/constants.dart';
import 'package:covidtrack/utils/country_data_model.dart';
import 'package:flutter/material.dart';
import 'package:covidtrack/utils/widgets.dart';
import 'package:http/http.dart' as http;

class StatsPage extends StatefulWidget {
  var data;
  StatsPage([this.data]);
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  DateTime dateTime = DateTime.now();
  Map<String, CountryData> dataMap;
  String date = '';
  var allCountryArray;
  CountryData mostCases, mostDeaths, mostRecovered;
  bool load = false;

  @override
  void initState() {
    if (widget.data != null) {
      allCountryArray = widget.data;
    } else {
      allCountryArray = null;
    }
    date = dateTime.day.toString() +
        ' ' +
        monthNames[dateTime.month - 1] +
        ' ' +
        dateTime.year.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomMenu(null),
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
                          headerText: 'Stats',
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 3),
                          child: Text(
                            'Most Cases',
                            style: kPrimaryTextStyle,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            toScreen(context, 'cases', allCountryArray);
                          },
                          child: DataCard(
                            color: Colors.amber,
                            countryUrl: snapshot.data['cases'].countryUrl,
                            countryName: snapshot.data['cases'].countryName,
                            totalData: snapshot.data['cases'].totalConfirmed,
                            newData: snapshot.data['cases'].newConfirmed,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 3),
                          child: Text(
                            'Most Recovered',
                            style: kPrimaryTextStyle,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            toScreen(context, 'recovered', allCountryArray);
                          },
                          child: DataCard(
                            color: Colors.greenAccent,
                            countryUrl: snapshot.data['recovered'].countryUrl,
                            countryName: snapshot.data['recovered'].countryName,
                            totalData:
                                snapshot.data['recovered'].totalRecovered,
                            newData: snapshot.data['recovered'].newRecovered,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 3),
                          child: Text(
                            'Most Deaths',
                            style: kPrimaryTextStyle,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            toScreen(context, 'deaths', allCountryArray);
                          },
                          child: DataCard(
                            color: Colors.redAccent,
                            countryUrl: snapshot.data['deaths'].countryUrl,
                            countryName: snapshot.data['deaths'].countryName,
                            totalData: snapshot.data['deaths'].totalDeath,
                            newData: snapshot.data['deaths'].newDeath,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 0),
                          child: Text(
                            'Last Updated $date',
                            style: kLastUpdatedTextStyle,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0.0, bottom: 10),
                          child: Text(
                            'Data might be subject to Inconsistency.',
                            style: kLastUpdatedTextStyle,
                          ),
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

  Future<Map<String, CountryData>> getData() async {
    http.Response response;
    var data;
    if (!load) {
      if (widget.data == null) {
        response = await http.get('https://api.covid19api.com/summary');
        if (response.statusCode == 200) {
          data = response.body;
          setState(() {
            allCountryArray = jsonDecode(data)['Countries'];
          });
        }
      }
      var tempMostCases, tempMostDeaths, tempMostRecovered;
      tempMostCases = allCountryArray[0];
      tempMostDeaths = allCountryArray[0];
      tempMostRecovered = allCountryArray[0];
      for (int i = 1; i < allCountryArray.length; i++) {
        if (tempMostCases['TotalConfirmed'] <
            allCountryArray[i]['TotalConfirmed'])
          tempMostCases = allCountryArray[i];
        if (tempMostDeaths['TotalDeaths'] < allCountryArray[i]['TotalDeaths'])
          tempMostDeaths = allCountryArray[i];
        if (tempMostRecovered['TotalRecovered'] <
            allCountryArray[i]['TotalRecovered'])
          tempMostRecovered = allCountryArray[i];
      }
      setState(() {
        mostCases = CountryData(
            countryUrl:
                'http://www.geognos.com/api/en/countries/flag/${tempMostCases['CountryCode'].toUpperCase()}.png',
            countryName: tempMostCases['Country'],
            newConfirmed: tempMostCases['NewConfirmed'],
            totalConfirmed: tempMostCases['TotalConfirmed']);
        mostDeaths = CountryData(
            countryName: tempMostDeaths['Country'],
            newDeath: tempMostDeaths['NewDeaths'],
            countryUrl:
                'http://www.geognos.com/api/en/countries/flag/${tempMostDeaths['CountryCode'].toUpperCase()}.png',
            totalDeath: tempMostDeaths['TotalDeaths']);
        mostRecovered = CountryData(
            newRecovered: tempMostRecovered['NewRecovered'],
            countryUrl:
                'http://www.geognos.com/api/en/countries/flag/${tempMostRecovered['CountryCode'].toUpperCase()}.png',
            countryName: tempMostRecovered['Country'],
            totalRecovered: tempMostRecovered['TotalRecovered']);
        dataMap = {
          'cases': mostCases,
          'recovered': mostRecovered,
          'deaths': mostDeaths
        };
      });

      load = true;
    }

    return dataMap;
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
