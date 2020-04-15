import 'dart:convert';

import 'package:covidtrack/screens/country_page.dart';
import 'package:covidtrack/utils/constants.dart';
import 'package:covidtrack/utils/country_data_model.dart';
import 'package:covidtrack/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataPage extends StatefulWidget {
  String type;
  DataPage({this.type});
  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  String type = '';
  Color color;
  List<CountryData> countryArray = List(246);
  List<CountryData> tempArray = List(246);
  bool loaded = false;
  TextEditingController controller;
  int totalReports = 5;
  @override
  void initState() {
    type = widget.type;
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
                  onTap: () {
                    Navigator.pop(context);
                  },
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
                            if (int.parse(value) < 246) {
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
                                toCountryPage(snapshot.data[index].shortName);
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
                                toCountryPage(snapshot.data[index].shortName);
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
                                toCountryPage(snapshot.data[index].shortName);
                              },
                              child: DataCard(
                                color: color,
                                countryUrl: snapshot.data[index].countryUrl,
                                countryName: snapshot.data[index].countryName,
                                totalData: snapshot.data[index].totalDeath,
                                newData: snapshot.data[index].newDeath,
                              ),
                            ),
                          );
                        }
                      }),
                ),
              ]);
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
          },
        ),
      ),
    );
  }

  Future<List<CountryData>> getData() async {
    if (!loaded) {
      http.Response response;
      var allCountryArray, data;

      response = await http.get('https://api.covid19api.com/summary');
      if (response.statusCode == 200) {
        data = response.body;
        allCountryArray = jsonDecode(data)['Countries'];
        countryArray = [];

        for (int i = 0; i < allCountryArray.length; i++) {
          tempArray[i] = CountryData(
              newRecovered: allCountryArray[i]['NewRecovered'],
              newConfirmed: allCountryArray[i]['NewConfirmed'],
              newDeath: allCountryArray[i]['NewDeaths'],
              totalRecovered: allCountryArray[i]['TotalRecovered'],
              totalDeath: allCountryArray[i]['TotalDeaths'],
              totalConfirmed: allCountryArray[i]['TotalConfirmed'],
              countryName: allCountryArray[i]['Country'],
              countryCode: allCountryArray[i]['CountryCode'],
              shortName: allCountryArray[i]['Slug'],
              countryUrl:
                  'http://www.geognos.com/api/en/countries/flag/${allCountryArray[i]['CountryCode'].toUpperCase()}.png');
        }
        countryArray = sortArray(tempArray, type);

        setState(() {
          loaded = true;
        });
        return countryArray;
      } else
        return [];
    } else
      return countryArray;
  }

  sortArray(List<CountryData> countryArray, String type) {
    for (int i = 0; i < countryArray.length; i++) {
      for (int j = 0; j < (countryArray.length - i - 1); j++) {
        if (countryArray[j].getTypes(type) <
            countryArray[j + 1].getTypes(type)) {
          var tempCountry = countryArray[j];
          countryArray[j] = countryArray[j + 1];
          countryArray[j + 1] = tempCountry;
        }
      }
    }
    return countryArray;
  }

  void toCountryPage(String countryName) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CountryPage(countryName: countryName);
    }));
  }
}
