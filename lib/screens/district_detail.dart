import 'package:covidtrack/utils/constants.dart';
import 'package:covidtrack/utils/models/district_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DistrictDetails extends StatefulWidget {
  final String stateName;
  final int total;
  DistrictDetails(this.stateName, this.total);
  @override
  _DistrictDetailsState createState() => _DistrictDetailsState();
}

class _DistrictDetailsState extends State<DistrictDetails> {
  DistrictList districtList;
  String stateName;
  int total;
  List<DistrictDataCard> dataCardWidgets;
  @override
  void initState() {
    total = widget.total;
    stateName = widget.stateName;
    districtList = DistrictList(districtList: []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length == 0) {
              return Center(
                child: Text('No data Available'),
              );
            } else
              return Padding(
                  padding: EdgeInsets.only(bottom: 20, left: 10, right: 10),
                  child: Column(
                    children: dataCardWidgets,
                  ));
          } else {
            return Center(
              child: Container(
                  width: 40,
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.greenAccent))),
            );
          }
        });
  }

  Future getData() async {
    await districtList.getAllDistrictData(stateName);
    buildDataWidgets();
    return districtList.districtList;
  }

  Future<List<DistrictDataCard>> buildDataWidgets() async {
    dataCardWidgets = [];
    for (int i = 0; i < districtList.districtList.length; i++)
      dataCardWidgets.add(DistrictDataCard(
        name: districtList.districtList[i].name,
        totalConfirmed: districtList.districtList[i].totalConfirmed,
        newConfirmed: districtList.districtList[i].newConfirmed,
        totalActive: districtList.districtList[i].totalActive,
        totalRecovered: districtList.districtList[i].totalRecovered,
        newRecovered: districtList.districtList[i].newRecovered,
        totalDeaths: districtList.districtList[i].totalDeaths,
        newDeaths: districtList.districtList[i].newDeaths,
        stateTotal: total,
      ));
    return dataCardWidgets;
  }
}

class DistrictDataCard extends StatelessWidget {
  final int totalConfirmed,
      totalDeaths,
      totalRecovered,
      newDeaths,
      newConfirmed,
      newRecovered,
      totalActive,
      stateTotal;
  final String name;
  DistrictDataCard(
      {this.name,
      this.stateTotal,
      this.totalDeaths,
      this.totalRecovered,
      this.totalConfirmed,
      this.newDeaths,
      this.newRecovered,
      this.newConfirmed,
      this.totalActive});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Material(
        elevation: 2,
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: <Widget>[
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 8),
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: kSecondaryTextStyle,
                ),
              ),
            ),
            Divider(),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Total Confirmed : ',
                  style: kTertiaryTextStyle,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      formatter.format(totalConfirmed).toString(),
                      style: kCaseNameTextStyle,
                    ),
                    Text(
                        ' (+' + formatter.format(newConfirmed).toString() + ')')
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Infection Rate : ',
                  style: kTertiaryTextStyle,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      ((totalConfirmed / stateTotal) * 100).toStringAsFixed(2),
                      style: kCaseNameTextStyle,
                    ),
                    Text(' %')
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Total Active : ',
                  style: kTertiaryTextStyle,
                ),
                Text(
                  formatter.format(totalActive).toString(),
                  style: kCaseNameTextStyle,
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Total Recovered : ',
                  style: kTertiaryTextStyle,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      formatter.format(totalRecovered).toString(),
                      style: kCaseNameTextStyle,
                    ),
                    Text(
                        ' (+' + formatter.format(newRecovered).toString() + ')')
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Recovery Rate : ',
                  style: kTertiaryTextStyle,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      ((totalRecovered / totalConfirmed) * 100)
                          .toStringAsFixed(2),
                      style: kCaseNameTextStyle,
                    ),
                    Text(' %')
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Total Deaths : ',
                  style: kTertiaryTextStyle,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      formatter.format(totalDeaths).toString(),
                      style: kCaseNameTextStyle,
                    ),
                    Text(' (+' + formatter.format(newDeaths).toString() + ')')
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Mortality Rate : ',
                  style: kTertiaryTextStyle,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      ((totalDeaths / totalConfirmed) * 100).toStringAsFixed(2),
                      style: kCaseNameTextStyle,
                    ),
                    Text(' %')
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
