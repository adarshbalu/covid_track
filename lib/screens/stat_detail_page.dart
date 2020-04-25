import 'package:covidtrack/screens/country_page.dart';
import 'package:covidtrack/utils/constants.dart';
import 'package:covidtrack/utils/models/country.dart';
import 'package:covidtrack/utils/models/country_list.dart';
import 'package:covidtrack/utils/navigation_transition.dart';
import 'package:covidtrack/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatDetail extends StatefulWidget {
  final String type;
  final data;
  StatDetail({this.type, this.data});
  @override
  _StatDetailState createState() => _StatDetailState();
}

class _StatDetailState extends State<StatDetail> {
  String type = '';
  Color color;
  List<CountryData> countryArray = List();
  CountryList countryList = CountryList();
  bool loaded = false;
  TextEditingController controller;
  int totalReports = 5;

  @override
  void initState() {
    type = widget.type;
    countryList =
        CountryList(countryList: widget.data, indiaData: CountryData());

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
                          return Container(
                            margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
                            child: InkWell(
                              onTap: () {
                                toCountryPage(snapshot.data[index].shortName,
                                    snapshot.data[index]);
                              },
                              child: DataCard(
                                color: color,
                                countryUrl: snapshot.data[index].countryUrl,
                                countryName: snapshot.data[index].countryName,
                                totalData: snapshot.data[index].totalRecovered,
                                newData: snapshot.data[index].newRecovered,
                              ),
                            ),
                          );
                        } else if (type == 'cases') {
                          return Container(
                            margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
                            child: InkWell(
                              onTap: () {
                                toCountryPage(snapshot.data[index].shortName,
                                    snapshot.data[index]);
                              },
                              child: DataCard(
                                color: color,
                                countryUrl: snapshot.data[index].countryUrl,
                                countryName: snapshot.data[index].countryName,
                                totalData: snapshot.data[index].totalConfirmed,
                                newData: snapshot.data[index].newConfirmed,
                              ),
                            ),
                          );
                        } else {
                          return Container(
                            margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
                            child: InkWell(
                              onTap: () {
                                toCountryPage(snapshot.data[index].shortName,
                                    snapshot.data[index]);
                              },
                              child: DataCard(
                                color: color,
                                countryUrl: snapshot.data[index].countryUrl,
                                countryName: snapshot.data[index].countryName,
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

  Future<List<CountryData>> getData() async {
    if (!loaded) {
      countryArray = countryList.sortCountryList(type);
      setState(() {
        loaded = true;
      });
    }

    return countryArray;
  }

  void toCountryPage(String countryName, var data) {
    Navigator.push(
        context,
        SlideRoute(
            widget: CountryPage(
          countryName: countryName,
          data: data,
        )));
  }
}
