import 'package:covidtrack/screens/home_page.dart';
import 'package:covidtrack/utils/widgets.dart';
import 'package:covidtrack/utils/constants.dart';
import 'package:covidtrack/utils/models/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  GlobalData globalData;
  bool load = false;

  @override
  void initState() {
    globalData = GlobalData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.none ||
                  snapshot.hasError) {
                return ErrorScreen();
              } else
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        kCOVIDImage,
                        width: MediaQuery.of(context).size.width / 1.5,
                        height: MediaQuery.of(context).size.height / 2,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 8,
                        ),
                        child: Text(
                          '#StayHome',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          '#StaySafe',
                          style: TextStyle(fontSize: 26),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.green)),
                    ],
                  ),
                );
            } else if (snapshot.connectionState == ConnectionState.none ||
                snapshot.hasError) {
              return ErrorScreen();
            } else {
              return HomePage(globalData);
            }
          }),
    );
  }

  getData() async {
    await globalData.getGlobalData();
    setState(() {
      if (globalData.totalConfirmed != null) load = true;
    });

    return globalData;
  }
}
