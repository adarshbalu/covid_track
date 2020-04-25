import 'package:covidtrack/screens/loading_screen.dart';
import 'package:covidtrack/screens/stat_detail_page.dart';
import 'package:covidtrack/utils/constants.dart';
import 'package:covidtrack/utils/models/country.dart';
import 'package:covidtrack/utils/models/country_list.dart';
import 'package:covidtrack/utils/navigation_transition.dart';
import 'package:flutter/material.dart';
import 'package:covidtrack/utils/widgets.dart';

class StatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  DateTime dateTime = DateTime.now();
  Map<String, CountryData> dataMap;
  CountryList countryList;
  String date = '';
  List<CountryData> countryDataList = List();
  CountryData mostCases, mostDeaths, mostRecovered;
  bool load = false;

  @override
  void initState() {
    dataMap = Map();
    countryList = CountryList(countryList: [], indiaData: CountryData());
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
      bottomNavigationBar: BottomMenu(),
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
                            toScreen(context, 'cases', countryDataList);
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
                            toScreen(context, 'recovered', countryDataList);
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
                            toScreen(context, 'deaths', countryDataList);
                          },
                          child: DataCard(
                            color: Colors.redAccent,
                            countryUrl: snapshot.data['deaths'].countryUrl,
                            countryName: snapshot.data['deaths'].countryName,
                            totalData: snapshot.data['deaths'].totalDeaths,
                            newData: snapshot.data['deaths'].newDeaths,
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
              } else if (snapshot.hasError ||
                  snapshot.connectionState == ConnectionState.none) {
                return ErrorScreen();
              } else {
                return LoaderScreen();
              }
            }),
      ),
    );
  }

  Future<Map<String, CountryData>> getData() async {
    if (!load) {
      var data = await countryList.getAllCountryData();

      setState(() {
        countryDataList = data;
      });

      mostCases = await countryList.getMost('cases');
      mostDeaths = await countryList.getMost('deaths');
      mostRecovered = await countryList.getMost('recovered');

      setState(() {
        load = true;
        dataMap = {
          'cases': mostCases,
          'recovered': mostRecovered,
          'deaths': mostDeaths
        };
      });
    }

    return dataMap;
  }

  void toScreen(BuildContext context, String type, var data) async {
    await Navigator.push(
        context,
        SlideRoute(
            widget: StatDetail(
          type: type,
          data: data,
        )));
  }
}
