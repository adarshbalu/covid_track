import 'package:covidtrack/utils/constants.dart';
import 'package:covidtrack/utils/country_data_model.dart';
import 'package:covidtrack/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class CountryPage extends StatefulWidget {
  String countryName;
  var data;
  CountryPage({this.countryName, this.data});
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  CountryData countryData;
  String countryName;
  String countryCode;
  DateTime dateTime = DateTime.now();
  String date = '';

  @override
  void initState() {
    countryData = widget.data;
    date = dateTime.day.toString() +
        ' ' +
        monthNames[dateTime.month - 1] +
        ' ' +
        dateTime.year.toString();
    countryName = widget.countryName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: getCountry(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          padding: EdgeInsets.only(top: 15, bottom: 15),
                          constraints:
                              BoxConstraints.tightFor(width: double.infinity),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(40),
                                  bottomLeft: Radius.circular(40)),
                              color: Colors.white,
                              backgroundBlendMode: BlendMode.colorDodge),
                          child: Text(
                            snapshot.data.countryName,
                            style: kSecondaryTextStyle,
                            textAlign: TextAlign.center,
                            softWrap: true,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CaseCard(
                          totalCases: snapshot.data.totalConfirmed,
                          isFlag: true,
                          flagURL: snapshot.data.countryUrl,
                          color: colorArray['white'],
                        ),
                        DataListTile(
                          color: Colors.deepPurple,
                          cases: snapshot.data.totalActive,
                          text: 'Active',
                        ),
                        DataListTile(
                          color: Colors.green,
                          cases: snapshot.data.totalRecovered,
                          text: 'Recovered',
                        ),
                        DataListTile(
                          color: Colors.red,
                          cases: snapshot.data.totalDeath,
                          text: 'Deaths',
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0, bottom: 10),
                          child: Text(
                            'Last Updated $date',
                            style: kLastUpdatedTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.none ||
                  snapshot.hasError) {
                return LoaderScreen(
                  text1: 'Some Issue Connecting',
                  text2: 'Please check network',
                  image: kHandWashImage,
                );
              } else {
                return LoaderScreen(
                  text1: 'Wash your hands with Soap',
                  text2: 'While we sync data for you  .. ',
                  image: kSanitizerImage,
                );
              }
            }),
      ),
    );
  }

  Future<CountryData> getCountry() async {
    countryData = widget.data;
//    http.Response response =
//        await http.get('https://api.covid19api.com/summary');
//    if (response.statusCode == 200) {
//      countryData = CountryData(
//          totalRecovered: 0,
//          totalActive: 0,
//          totalConfirmed: 0,
//          totalDeath: 0,
//          countryName: '',
//          countryCode: '',
//          countryUrl: '');
    // var data = response.body;
    //var countryDetails = jsonDecode(data)['Countries'];
    //for (var country in countryDetails) {
    //if (country['Slug'] == countryName)
//          setState(() {
//            countryCode = country['CountryCode'];
//            if (countryCode == null) countryCode = ' ';
//            countryData.countryName = country['Country'];
//            countryData.totalConfirmed = country['TotalConfirmed'];
//            countryData.totalDeath = country['TotalDeaths'];
//            countryData.totalRecovered = country['TotalRecovered'];
//            countryData.totalActive = countryData.totalConfirmed -
//                (countryData.totalRecovered - countryData.totalDeath);
//            countryData.countryUrl =
//                'http://www.geognos.com/api/en/countries/flag/${countryCode.toUpperCase()}.png';
//          });
//      }
//    }
    return countryData;
  }
}
