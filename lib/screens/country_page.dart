import 'package:covidtrack/screens/loading_screen.dart';
import 'package:covidtrack/utils/constants.dart';
import 'package:covidtrack/utils/models/content.dart';
import 'package:covidtrack/utils/models/content_list.dart';
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
  ContentsList contentsList;
  Content content;

  @override
  void initState() {
    content = Content();
    contentsList = ContentsList();
    contentsList.contents = contentsList.getAllContents();
    content =
        contentsList.contents[random.nextInt(contentsList.contents.length)];
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
                return ErrorScreen();
              } else {
                return LoaderScreen(
                  text: content.text,
                  image: content.text,
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
