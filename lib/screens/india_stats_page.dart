import 'package:covidtrack/screens/india_stats_detail_page.dart';
import 'package:covidtrack/screens/loading_screen.dart';
import 'package:covidtrack/utils/constants.dart';
import 'package:covidtrack/utils/models/content_list.dart';
import 'package:covidtrack/utils/models/state_data.dart';
import 'package:covidtrack/utils/models/state_list.dart';
import 'package:covidtrack/utils/navigation_transition.dart';
import 'package:covidtrack/utils/widgets.dart';
import 'package:flutter/material.dart';

class IndiaStatsPage extends StatefulWidget {
  @override
  _IndiaStatsPageState createState() => _IndiaStatsPageState();
}

class _IndiaStatsPageState extends State<IndiaStatsPage> {
  ContentsList contentsList;
  StateList stateList;
  List<StateData> stateDataList;
  Map<String, StateData> dataMap;
  StateData mostCases, mostDeaths, mostRecovered;
  bool load = false;
  @override
  void initState() {
    contentsList = ContentsList();
    contentsList.contents = contentsList.getAllContents();
    contentsList.content =
        contentsList.contents[random.nextInt(contentsList.contents.length)];
    stateList = StateList();
    stateDataList = List();
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
                          headerText: 'States',
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 3),
                          child: Text(
                            'Cases',
                            style: kPrimaryTextStyle,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            toScreen(context, 'cases', stateDataList);
                          },
                          child: DataCard(
                            color: Colors.amber,
                            countryUrl:
                                'http://www.geognos.com/api/en/countries/flag/IN.png',
                            countryName: snapshot.data['cases'].name,
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
                            toScreen(context, 'recovered', stateDataList);
                          },
                          child: DataCard(
                            color: Colors.greenAccent,
                            countryUrl:
                                'http://www.geognos.com/api/en/countries/flag/IN.png',
                            countryName: snapshot.data['recovered'].name,
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
                            toScreen(context, 'deaths', stateDataList);
                          },
                          child: DataCard(
                            color: Colors.redAccent,
                            countryUrl:
                                'http://www.geognos.com/api/en/countries/flag/IN.png',
                            countryName: snapshot.data['deaths'].name,
                            totalData: snapshot.data['deaths'].totalDeaths,
                            newData: snapshot.data['deaths'].newDeaths,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.none ||
                  snapshot.hasError) {
                return ErrorScreen();
              } else {
                return LoaderScreen(
                  text: contentsList.content.text,
                  image: contentsList.content.image,
                );
              }
            }),
      ),
    );
  }

  Future getData() async {
    if (!load) {
      var data;
      data = await stateList.getAllStateData();
      setState(() {
        stateDataList = data.stateList;
      });

      mostCases = await stateList.getMost('cases');
      mostDeaths = await stateList.getMost('deaths');
      mostRecovered = await stateList.getMost('recovered');

      setState(() {
        dataMap = {
          'cases': mostCases,
          'recovered': mostRecovered,
          'deaths': mostDeaths
        };
        load = true;
      });
    }
    return dataMap;
  }

  void toScreen(BuildContext context, String type, var data) async {
    await Navigator.push(
        context,
        SlideRoute(
            widget: IndiaStatDetail(
          type: type,
          data: data,
        )));
  }
}
