import 'package:covidtrack/utils/constants.dart';
import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          CircleAvatar(
            radius: 25,
            child: Icon(
              Icons.search,
              color: Colors.white,
              size: 45,
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
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25.0, right: 15),
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: color,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    cases.toString(),
                    style: kCaseNumberTextStyle,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 28.0),
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
  @override
  Widget build(BuildContext context) {
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
          Text(
            '111,500',
            style: kTotalCaseNumberTextStyle,
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
