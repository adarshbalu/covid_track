import 'dart:convert';
import 'package:covidtrack/screens/country_page.dart';
import 'package:covidtrack/utils/constants.dart';
import 'package:covidtrack/utils/country_data_model.dart';
import 'package:covidtrack/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CountrySelectPage extends StatefulWidget {
  @override
  _CountrySelectPageState createState() => _CountrySelectPageState();
}

class _CountrySelectPageState extends State<CountrySelectPage> {
  List<CountryData> countryDataList = [];
  TextEditingController _controller = TextEditingController();
  Color color = Colors.red;
  bool search = false;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  String tempCountry;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AppHeader(
            onTap: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Country Outbreak',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 30,
              ),
              Expanded(
                flex: 3,
                child: TextField(
                  onSubmitted: (value) {
                    for (var country in countryDataList) {
                      if (country.countryName == value) {
                        setState(() {
                          color = Colors.green;
                          search = true;
                          tempCountry = country.shortName;
                        });
                      } else {
                        setState(() {
                          color = Colors.red;
                          search = false;
                        });
                      }
                    }
                  },
                  autofocus: true,
                  controller: _controller,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                  decoration: InputDecoration(
                    helperText: 'Enter Name of Country',
                    helperStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
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
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: search
                      ? () {
                          toCountryPage(tempCountry);
                        }
                      : () {},
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: color,
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Country List',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 20,
          ),
          Flexible(
            child: FutureBuilder(
                future: getCountryData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Card(
                              margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
                              elevation: 2,
                              child: ListTile(
                                onTap: () {
                                  toCountryPage(snapshot.data[index].shortName);
                                },
                                title: Text(snapshot.data[index].countryName),
                              ));
                        });
                  } else {
                    return Center(
                      child: Container(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                }),
          )
        ],
      ),
    ));
  }

  bool load = false;
  Future<List<CountryData>> getCountryData() async {
    if (!load) {
      List<CountryData> tempCountryDataList = [];
      http.Response response =
          await http.get('https://api.covid19api.com/summary');
      if (response.statusCode == 200) {
        var data = response.body;
        CountryData countryData;
        var countryList = jsonDecode(data)['Countries'];
        for (var country in countryList) {
          countryData = CountryData(
            totalRecovered: 0,
            totalActive: 0,
            totalConfirmed: 0,
            totalDeath: 0,
            countryName: '',
          );
          setState(() {
//            countryData.totalConfirmed = country['TotalConfirmed'];
//            countryData.totalDeath = country['TotalDeaths'];
//            countryData.totalRecovered = country['TotalRecovered'];
//            countryData.newRecovered = country['NewRecovered'];
//            countryData.newDeaths = country['NewDeaths'];
//            countryData.newConfirmed = country['NewConfirmed'];
            countryData.countryName = country['Country'];
//            countryData.totalActive = countryData.totalConfirmed -
//                (countryData.totalRecovered + countryData.totalDeath);
//            countryData.newActive = countryData.newConfirmed -
//                (countryData.newRecovered + countryData.newDeaths);
            countryData.shortName = country['Slug'];
          });
          tempCountryDataList.add(countryData);
        }
        load = true;
        countryDataList = tempCountryDataList;
      }
      return tempCountryDataList;
    } else
      return countryDataList;
  }

  void toCountryPage(String countryName) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CountryPage(countryName: countryName);
    }));
  }
}
