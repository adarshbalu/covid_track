import 'package:covidtrack/screens/india_stats_page.dart';
import 'package:covidtrack/utils/constants.dart';
import 'package:covidtrack/utils/models/country.dart';
import 'package:covidtrack/utils/models/state_data.dart';
import 'package:covidtrack/utils/models/state_list.dart';
import 'package:covidtrack/utils/navigation_transition.dart';
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
                        InkWell(
                          onTap:
                              snapshot.data.countryName.toLowerCase() == 'india'
                                  ? () {
                                      Navigator.push(context,
                                          SlideRoute(widget: IndiaStatsPage()));
                                    }
                                  : () {},
                          child: CaseCard(
                            totalCases: snapshot.data.totalConfirmed,
                            isFlag: true,
                            flagURL: snapshot.data.countryUrl,
                            color: colorArray['purple'],
                          ),
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
                    countryName == 'india'
                        ? FutureBuilder(
                            future: null,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Column(
                                  children: <Widget>[
                                    Container(
                                      child: Text(snapshot.data.length),
                                    )
                                  ],
                                );
                              } else {
                                return CircularProgressIndicator();
                              }
                            })
                        : SizedBox()
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

  Future getState() async {
    var data = await stateList.getAllStateData();

    setState(() {
      stateDataList = data.stateList;
    });

    return stateDataList;
  }
}
