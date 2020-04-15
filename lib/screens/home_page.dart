import 'dart:convert';
import 'package:covidtrack/screens/country_select_page.dart';
import 'package:covidtrack/screens/data_display_page.dart';
import 'package:covidtrack/utils/constants.dart';
import 'package:covidtrack/utils/country_data_model.dart';
import 'package:covidtrack/utils/global_data_model.dart';
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
  DateTime dateTime = DateTime.now();
  String date = '';
  CountryData mostCases, mostDeaths, mostRecovered;
  bool load = false;
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
                          onTap: () async {
                            toCountrySelectPage();
                          },
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          'World Outbreak',
                          style: kPrimaryTextStyle,
                        ),
                        CaseCard(
                          totalCases: snapshot.data.totalConfirmed,
                          isFlag: false,
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
//                        DataListTile(
//                          color: Colors.deepPurple,
//                          cases: snapshot.data.newActive,
//                          text: 'New Active',
//                        ),
//                        DataListTile(
//                          color: Colors.green,
//                          cases: snapshot.data.newRecovered,
//                          text: 'New Recovered',
//                        ),
//                        DataListTile(
//                          color: Colors.red,
//                          cases: snapshot.data.newDeaths,
//                          text: 'New Deaths',
//                        ),
                        SizedBox(
                          height: 8,
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
                            toScreen(context, 'cases');
                          },
                          child: DataCard(
                            color: Colors.amber,
                            countryUrl: mostCases.countryUrl,
                            countryName: mostCases.countryName,
                            totalData: mostCases.totalConfirmed,
                            newData: mostCases.newConfirmed,
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
                            toScreen(context, 'recovered');
                          },
                          child: DataCard(
                            color: Colors.greenAccent,
                            countryUrl: mostRecovered.countryUrl,
                            countryName: mostRecovered.countryName,
                            totalData: mostRecovered.totalRecovered,
                            newData: mostRecovered.newRecovered,
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
                            toScreen(context, 'deaths');
                          },
                          child: DataCard(
                            color: Colors.redAccent,
                            countryUrl: mostDeaths.countryUrl,
                            countryName: mostDeaths.countryName,
                            totalData: mostDeaths.totalDeath,
                            newData: mostDeaths.newDeath,
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
        });

        var allCountryArray = jsonDecode(data)['Countries'];
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
        });
      }
      load = true;
    }
    return globalData;
  }

  void toScreen(BuildContext context, String type) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return DataPage(type: type);
    }));
  }
}
