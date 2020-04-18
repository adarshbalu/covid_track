import 'package:covidtrack/screens/country_page.dart';
import 'package:covidtrack/screens/country_select_page.dart';
import 'package:covidtrack/screens/home_page.dart';
import 'package:covidtrack/screens/stats_page.dart';
import 'package:covidtrack/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

var formatter = NumberFormat("##,##,##,###");

class AppHeader extends StatelessWidget {
  String headerText = '';
  var data, name;
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CountryPage(
                          countryName: name,
                          data: data,
                        );
                      }));
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
  bool isFlag;
  String flagURL;
  var color;
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
                  width: 100,
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

class LoaderScreen extends StatelessWidget {
  final String text1, text2, image;
  final Function onTap;
  LoaderScreen({this.text1, this.text2, this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
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
            text1,
            style: kSecondaryTextStyle,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: Text(
            text2,
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

class DataCard extends StatelessWidget {
  DataCard(
      {this.countryUrl,
      this.countryName,
      this.color,
      this.newData,
      this.totalData,
      this.onTap});

  final String countryUrl, countryName;
  final int totalData, newData;
  final Color color;
  var totalCaseNumber;
  Function onTap;
  @override
  Widget build(BuildContext context) {
    totalCaseNumber = formatter.format(totalData);

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
  var allCountryArray;
  BottomMenu([this.allCountryArray]);
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
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HomePage();
                }));
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
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CountrySelectPage();
                }));
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
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return StatsPage();
                }));
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.note,
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
  final String name;
  CountryNameHeader(this.name);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.only(top: 15, bottom: 15),
      constraints: BoxConstraints.tightFor(width: double.infinity),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(40),
              bottomLeft: Radius.circular(40)),
          color: Colors.white,
          backgroundBlendMode: BlendMode.colorDodge),
      child: Text(
        name,
        style: kSecondaryTextStyle,
        textAlign: TextAlign.center,
        softWrap: true,
      ),
    );
  }
}
