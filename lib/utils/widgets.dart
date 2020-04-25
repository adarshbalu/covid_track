import 'dart:math';
import 'package:covidtrack/screens/india_home_page.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covidtrack/screens/country_select_page.dart';
import 'package:covidtrack/screens/home_page.dart';
import 'package:covidtrack/screens/stats_page.dart';
import 'package:covidtrack/utils/constants.dart';
import 'package:covidtrack/utils/navigation_transition.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AppHeader extends StatelessWidget {
  final headerText;
  final data, name;
  AppHeader({this.headerText, this.name, this.data});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 2,
      child: Container(
        padding: EdgeInsets.only(bottom: 15, top: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 0),
              child: Image.asset(
                kGermImage,
                width: 50,
              ),
            ),
            Text(
              headerText,
              style: kHeaderTextStyle,
            ),
            headerText == 'Countries'
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context, SlideRoute(widget: IndiaHomePage()));
                    },
                    child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: Image.asset(
                          kIndiaImage,
                          width: 50,
                          height: 50,
                        )),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}

class DataListTile extends StatelessWidget {
  final Color color;
  final int cases;
  final String text;
  DataListTile({this.text, this.color, this.cases});

  @override
  Widget build(BuildContext context) {
    var caseNumber;
    caseNumber = formatter.format(cases);
    return Center(
      child: Container(
        margin: EdgeInsets.all(6),
        height: 70,
        width: MediaQuery.of(context).size.width / 1.2,
        color: Colors.transparent,
        child: Material(
          color: Colors.white,
          elevation: 2,
          borderRadius: BorderRadius.circular(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 15),
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: color,
                    ),
                  ),
                  Text(
                    caseNumber.toString(),
                    style: kSecondaryTextStyle,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  text,
                  style: kCaseNameTextStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CaseCard extends StatelessWidget {
  final int totalCases;
  final bool isFlag;
  final String flagURL;
  final color;
  CaseCard({this.totalCases, this.isFlag, this.flagURL, this.color});
  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat("##,##,##,###");
    var caseNumber;
    caseNumber = formatter.format(totalCases);
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.fromLTRB(20, 5, 20, 10),
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 3.2,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: color,
          ),
          boxShadow: [BoxShadow(color: Colors.blueGrey, blurRadius: 3)],
          borderRadius: BorderRadius.circular(40)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          !isFlag
              ? Image.asset(
                  kSickImage,
                  height: 80,
                )
              : Image.network(
                  flagURL,
                  width: 80,
                ),
          Padding(
            padding: EdgeInsets.only(top: 5.0, bottom: 5),
            child: Text(
              caseNumber.toString(),
              style: kSecondaryTextStyleWhite,
            ),
          ),
          Text(
            'TOTAL CASES',
            style: TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}

class DataCard extends StatelessWidget {
  DataCard({
    this.countryUrl,
    this.countryName,
    this.color,
    this.newData,
    this.totalData,
  });

  final String countryUrl, countryName;
  final int totalData, newData;
  final Color color;

  @override
  Widget build(BuildContext context) {
    var totalCaseNumber = formatter.format(totalData);

    return Container(
      margin: EdgeInsets.fromLTRB(6, 0, 6, 10),
      height: 100,
      width: MediaQuery.of(context).size.width / 1.1,
      color: Colors.transparent,
      child: Material(
          color: Colors.white,
          elevation: 2,
          borderRadius: BorderRadius.circular(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.network(
                    countryUrl,
                    width: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      countryName,
                      softWrap: true,
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    totalCaseNumber.toString(),
                    style: kCaseNameTextStyle,
                  ),
                  Text(' ( + '),
                  Text(
                    newData.toString(),
                    style: TextStyle(color: color),
                  ),
                  Text(' )')
                ],
              ),
            ],
          )),
    );
  }
}

class BottomMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height / 10,
        decoration: BoxDecoration(
            //color: Colors.deepPurple,
            gradient: LinearGradient(
              colors: [Colors.black45, Colors.black54],
            ),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context, SlideRoute(widget: HomePage(null)));
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.home,
                      size: 35,
                      color: Colors.white,
                    ),
                    Text(
                      'Home',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.push(
                    context, SlideRoute(widget: CountrySelectPage()));
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.public,
                      size: 35,
                      color: Colors.white,
                    ),
                    Text(
                      'Countries',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.push(context, SlideRoute(widget: StatsPage()));
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.assessment,
                      size: 40,
                      color: Colors.white,
                    ),
                    Text(
                      'Stats',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                SystemNavigator.pop(animated: true);
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.close,
                      size: 40,
                      color: Colors.white,
                    ),
                    Text(
                      'Exit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CountryNameHeader extends StatelessWidget {
  final String name, url;

  CountryNameHeader(this.name, this.url);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.only(top: 15, bottom: 15),
      constraints: BoxConstraints.tightFor(width: double.infinity),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(5), bottomLeft: Radius.circular(5)),
          color: Colors.white,
          backgroundBlendMode: BlendMode.colorDodge),
      child: ListTile(
        leading: Image.network(
          url,
          height: 40,
          width: 40,
        ),
        title: Text(
          name.toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 25,
              fontFamily: 'Merienda'),
          softWrap: true,
        ),
      ),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  static List<String> imageList = [kPandemic_1_Image, kPandemic_2_Image];
  static final random = new Random();
  final image = imageList[random.nextInt(2)];
  ErrorScreen();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height / 3.5,
        ),
        Image.asset(
          image,
          width: 80,
          height: 80,
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: Text(
            ' Connection not available',
            style: kSecondaryTextStyle,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: Text(
            'Please check network',
            style: kCaseNameTextStyle,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.transparent,
          ),
        ),
      ],
    );
  }
}

class StateDataCard extends StatelessWidget {
  StateDataCard({
    this.name,
    this.color,
    this.newData,
    this.totalData,
  });

  final String name;
  final int totalData, newData;
  final Color color;

  @override
  Widget build(BuildContext context) {
    var totalCaseNumber = formatter.format(totalData);

    return Container(
      margin: EdgeInsets.fromLTRB(6, 0, 6, 10),
      height: 100,
      width: MediaQuery.of(context).size.width / 1.1,
      color: Colors.transparent,
      child: Material(
          color: Colors.white,
          elevation: 2,
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: Text(
                  name,
                  softWrap: true,
                  style: TextStyle(fontSize: 22),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    totalCaseNumber.toString(),
                    style: kCaseNameTextStyle,
                  ),
                  Text(' ( + '),
                  Text(
                    newData.toString(),
                    style: TextStyle(color: color),
                  ),
                  Text(' )')
                ],
              ),
            ],
          )),
    );
  }
}

class CountryDataCard extends StatelessWidget {
  final Color color;
  final String header;
  final int totalCases, newCases;

  CountryDataCard({this.color, this.totalCases, this.header, this.newCases});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 10, 20, 10),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 3,
        child: Container(
            padding: EdgeInsets.only(top: 15, bottom: 15),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.white, Colors.white70]),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: <Widget>[
                Text(
                  header,
                  style: kSecondaryTextStyle,
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: color, borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        formatter.format(totalCases).toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(Icons.arrow_upward),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xffe0f7fa),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(formatter.format(newCases).toString()),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

class PieChart extends StatelessWidget {
  final List<Case> pieData;
  PieChart(this.pieData, this.animate);
  final bool animate;

  @override
  Widget build(BuildContext context) {
    List<charts.Series<Case, String>> _seriesPieData = [
      charts.Series(
        domainFn: (Case task, _) => task.type,
        measureFn: (Case task, _) => task.value,
        colorFn: (Case task, _) =>
            charts.ColorUtil.fromDartColor(task.colorValue),
        id: 'Cases',
        data: pieData,
        labelAccessorFn: (Case row, _) => '',
      ),
    ];
    return charts.PieChart(_seriesPieData,
        animate: animate,
        animationDuration: Duration(seconds: 3),
        behaviors: [
          charts.DatumLegend(
            outsideJustification: charts.OutsideJustification.endDrawArea,
            horizontalFirst: false,
            desiredMaxRows: 1,
            cellPadding: EdgeInsets.only(right: 4.0, bottom: 4.0),
            entryTextStyle: charts.TextStyleSpec(
                color: charts.MaterialPalette.black, fontSize: 11),
          )
        ],
        defaultRenderer: charts.ArcRendererConfig(
            arcWidth: 100,
            arcRendererDecorators: [
              charts.ArcLabelDecorator(
                  labelPosition: charts.ArcLabelPosition.inside)
            ]));
  }
}

class BarChart extends StatelessWidget {
  final List<Case> data;
  BarChart(this.data);
  @override
  Widget build(BuildContext context) {
    List<charts.Series<Case, String>> series = [
      charts.Series(
        id: 'New Cases',
        data: data,
        domainFn: (Case cases, int) => cases.type,
        measureFn: (Case cases, int) => cases.value,
        colorFn: (Case cases, int) => cases.barColor,
      )
    ];
    return charts.BarChart(
      series,
      animate: true,
      animationDuration: Duration(seconds: 2),
    );
  }
}

class Case {
  String type;
  int value;
  Color colorValue;
  charts.Color barColor;
  Case({this.type, this.value, this.colorValue, this.barColor});
}
