import 'package:covidtrack/utils/constants.dart';
import 'package:covidtrack/utils/models/country.dart';
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

  @override
  void initState() {
    countryData = widget.data;
    countryName = widget.countryName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomMenu(null),
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
                        CountryNameHeader(snapshot.data.countryName),
                        SizedBox(
                          height: 15,
                        ),
                        CaseCard(
                          totalCases: snapshot.data.totalConfirmed,
                          isFlag: true,
                          flagURL: snapshot.data.countryUrl,
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
                      ],
                    ),
                    countryName == 'india' ? SizedBox() : SizedBox()
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
    countryData.getCountryData(widget.data);
    return countryData;
  }
}
