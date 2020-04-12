import 'package:covidtrack/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppHeader extends StatelessWidget {
  Function onTap;
  String url = '';
  AppHeader({this.onTap, this.url});
  @override
  Widget build(BuildContext context) {
    if (url == null) url = '';
    return Container(
      padding: EdgeInsets.only(bottom: 20, top: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(45),
              bottomRight: Radius.circular(45))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Image.asset(
            kGermImage,
            width: 50,
          ),
          Text(
            'COVID-19',
            style: kHeaderTextStyle,
          ),
          GestureDetector(
            onTap: () {
              onTap();
            },
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: url.isEmpty
                  ? Icon(
                      Icons.public,
                      color: Colors.blue,
                      size: 45,
                    )
                  : Image.network(
                      url,
                      width: 40,
                      height: 40,
                    ),
            ),
          )
        ],
      ),
    );
  }
}

class DataListTile extends StatelessWidget {
  Color color;
  int cases;
  String text;
  DataListTile({this.text, this.color, this.cases});

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat("##,##,##,###");
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
                    style: kCaseNumberTextStyle,
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
  int totalCases;
  CaseCard({this.totalCases});
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
            colors: [
              Colors.deepPurpleAccent,
              Colors.deepPurple,
            ],
          ),
          boxShadow: [BoxShadow(color: Colors.blueGrey, blurRadius: 3)],
          borderRadius: BorderRadius.circular(40)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            kSickImage,
            height: 80,
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0, bottom: 5),
            child: Text(
              caseNumber.toString(),
              style: kTotalCaseNumberTextStyle,
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
  String text1, text2, image;
  Function onTap;
  LoaderScreen({this.text1, this.text2, this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () => onTap(),
          child: AppHeader(),
        ),
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
            style: kCaseNumberTextStyle,
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
