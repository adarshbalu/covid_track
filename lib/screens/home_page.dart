import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
//            SizedBox(
//              height: 5,
//            ),
            Container(
              padding: EdgeInsets.only(bottom: 20, top: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Image.asset(
                    'assets/germ.png',
                    width: 50,
                  ),
                  Text(
                    'COVID-19',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
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
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'World Outbreak',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
            ),
            Container(
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
                    'assets/sick.png',
                    height: 80,
                  ),
                  Text(
                    '111,500',
                    style: TextStyle(color: Colors.white, fontSize: 35),
                  ),
                  Text(
                    'TOTAL CASES',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            DataListTile(
              color: Colors.deepPurple,
              cases: 80677,
              text: 'Active',
            ),
            DataListTile(
              color: Colors.green,
              cases: 16765,
              text: 'Recovered',
            ),
            DataListTile(
              color: Colors.red,
              cases: 13272,
              text: 'Deaths',
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                'Last Updated on 10 March 2020',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
          ],
        ),
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
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 28.0),
                child: Text(
                  text,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
