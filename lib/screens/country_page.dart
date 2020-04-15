import 'dart:convert';
import 'package:covidtrack/utils/constants.dart';
import 'package:covidtrack/utils/country_data_model.dart';
import 'package:covidtrack/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class CountryPage extends StatefulWidget {
  String countryName;
  CountryPage({this.countryName});
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  CountryData countryData;
  String countryName;
  String countryCode;
  DateTime dateTime = DateTime.now();
  String date = '';

  @override
  void initState() {
    date = dateTime.day.toString() +
        ' ' +
        monthNames[dateTime.month - 1] +
        ' ' +
        dateTime.year.toString();
    countryName = widget.countryName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        AppHeader.withName(
                          url: snapshot.data.countryUrl,
                          onTap: () async {
                            Navigator.pop(context);
                          },
                          headerText: snapshot.data.countryName,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CaseCard(
                          totalCases: snapshot.data.totalConfirmed,
                          isFlag: true,
                          flagURL: snapshot.data.countryUrl,
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
                          padding: EdgeInsets.only(top: 8.0, bottom: 10),
                          child: Text(
                            'Last Updated $date',
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
                  image: kHandWashImage,
                );
              } else {
                return LoaderScreen(
                  text1: 'Wash your hands with Soap',
                  text2: 'While we sync data for you  .. ',
                  image: kSanitizerImage,
                );
              }
            }),
      ),
    );
  }

  Future<CountryData> getCountry() async {
    http.Response response =
        await http.get('https://api.covid19api.com/summary');
    if (response.statusCode == 200) {
      countryData = CountryData(
          totalRecovered: 0,
          totalActive: 0,
          totalConfirmed: 0,
          totalDeath: 0,
          countryName: '',
          countryCode: '',
          countryUrl: '');
      var data = response.body;
      var countryDetails = jsonDecode(data)['Countries'];
      for (var country in countryDetails) {
        if (country['Slug'] == countryName)
          setState(() {
            countryCode = country['CountryCode'];
            if (countryCode == null) countryCode = ' ';
            countryData.countryName = country['Country'];
            countryData.totalConfirmed = country['TotalConfirmed'];
            countryData.totalDeath = country['TotalDeaths'];
            countryData.totalRecovered = country['TotalRecovered'];
            countryData.totalActive = countryData.totalConfirmed -
                (countryData.totalRecovered - countryData.totalDeath);
            countryData.countryUrl =
                'http://www.geognos.com/api/en/countries/flag/${countryCode.toUpperCase()}.png';
          });
      }
    }
    return countryData;
  }
}
