import 'package:covidtrack/screens/state_page.dart';
import 'package:covidtrack/utils/constants.dart';
import 'package:covidtrack/utils/models/content_list.dart';
import 'package:covidtrack/utils/models/state_data.dart';
import 'package:covidtrack/utils/models/state_list.dart';
import 'package:covidtrack/utils/navigation_transition.dart';
import 'package:covidtrack/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IndiaStatDetail extends StatefulWidget {
  final String type;
  final data;
  IndiaStatDetail({this.type, this.data});
  @override
  _IndiaStatDetailState createState() => _IndiaStatDetailState();
}

class _IndiaStatDetailState extends State<IndiaStatDetail> {
  String type = '';
  Color color;
  List<StateData> statesArray = List();
  StateList stateList = StateList();
  bool loaded = false;
  TextEditingController controller;
  int totalReports = 5;
  ContentsList contentsList;

  @override
  void initState() {
    contentsList = ContentsList();
    contentsList.contents = contentsList.getAllContents();
    contentsList.content =
        contentsList.contents[random.nextInt(contentsList.contents.length)];

    type = widget.type;
    stateList = StateList(stateList: widget.data, totalData: StateData());

    switch (type) {
      case 'cases':
        color = Colors.deepPurple;
        break;
      case 'recovered':
        color = Colors.greenAccent;
        break;
      case 'deaths':
        color = Colors.deepOrange;
    }
    controller = TextEditingController(text: totalReports.toString());
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: BottomMenu(null),
      body: SafeArea(
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(children: <Widget>[
                AppHeader(
                  headerText: type.toUpperCase(),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: width / 3,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 2, 20, 5),
                        child: TextField(
                          onChanged: (value) {
                            if (int.parse(value) < snapshot.data.length &&
                                int.parse(value) > 0) {
                              setState(() {
                                totalReports = int.parse(value);
                              });
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Records',
                            helperText: 'Max : ${snapshot.data.length}',
                            helperStyle: TextStyle(color: color),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.green,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.indigo,
                                width: 2,
                              ),
                            ),
                          ),
                          maxLines: 1,
                          keyboardType: TextInputType.number,
                          maxLengthEnforced: true,
                          controller: controller,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width / 3,
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Center(
                    child: Text(
                      'Most $type'.toUpperCase(),
                      style: kPrimaryTextStyle,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Flexible(
                  child: ListView.builder(
                      itemCount: totalReports,
                      itemBuilder: (context, index) {
                        if (type == 'recovered') {
                          return InkWell(
                            onTap: () {
                              toStatePage(snapshot.data[index].name,
                                  snapshot.data[index]);
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
                              child: DataCard(
                                color: color,
                                countryUrl:
                                    'http://www.geognos.com/api/en/countries/flag/IN.png',
                                countryName: snapshot.data[index].name,
                                totalData: snapshot.data[index].totalRecovered,
                                newData: snapshot.data[index].newRecovered,
                              ),
                            ),
                          );
                        } else if (type == 'cases') {
                          return InkWell(
                            onTap: () {
                              toStatePage(snapshot.data[index].name,
                                  snapshot.data[index]);
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
                              child: DataCard(
                                color: color,
                                countryUrl:
                                    'http://www.geognos.com/api/en/countries/flag/IN.png',
                                countryName: snapshot.data[index].name,
                                totalData: snapshot.data[index].totalConfirmed,
                                newData: snapshot.data[index].newConfirmed,
                              ),
                            ),
                          );
                        } else {
                          return InkWell(
                            onTap: () {
                              toStatePage(snapshot.data[index].name,
                                  snapshot.data[index]);
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
                              child: DataCard(
                                color: color,
                                countryUrl:
                                    'http://www.geognos.com/api/en/countries/flag/IN.png',
                                countryName: snapshot.data[index].name,
                                totalData: snapshot.data[index].totalDeaths,
                                newData: snapshot.data[index].newDeaths,
                              ),
                            ),
                          );
                        }
                      }),
                ),
              ]);
            } else {
              return ErrorScreen();
            }
          },
        ),
      ),
    );
  }

  Future<List<StateData>> getData() async {
    if (!loaded) {
      statesArray = stateList.sortStateList(type);
      setState(() {
        loaded = true;
      });
    }

    return statesArray;
  }

  void toStatePage(String stateName, var data) {
    Navigator.push(
        context,
        SlideRoute(
            widget: StatePage(
          stateName: stateName,
          data: data,
        )));
  }
}
