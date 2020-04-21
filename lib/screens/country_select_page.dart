import 'package:covidtrack/screens/country_page.dart';
import 'package:covidtrack/utils/models/country.dart';
import 'package:covidtrack/utils/models/country_list.dart';
import 'package:covidtrack/utils/navigation_transition.dart';
import 'package:covidtrack/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountrySelectPage extends StatefulWidget {
  @override
  _CountrySelectPageState createState() => _CountrySelectPageState();
}

class _CountrySelectPageState extends State<CountrySelectPage> {
  CountryList allCountryList;
  TextEditingController _controller = TextEditingController();
  Color color = Colors.red;
  bool search = false;
  String url = '', name;
  CountryData countryData, indiaData;
  var countryList;
  List<CountryData> countryDataList;
  bool load = false;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    allCountryList = CountryList(countryList: [], indiaData: CountryData());
    super.initState();
  }

  String tempCountry;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomMenu(countryList),
        body: SafeArea(
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AppHeader(
                headerText: 'Countries',
                data: indiaData,
                name: name,
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
                      onChanged: (value) {
                        setState(() {
                          search = true;
                          color = Colors.green;
                        });
                      },
                      onSubmitted: (value) {
                        for (var country in countryDataList) {
                          if (country.countryName.toLowerCase() ==
                              value.toLowerCase()) {
                            setState(() {
                              search = true;
                              tempCountry = country.shortName;
                            });
                          }
                        }
                        if (!search) {
                          setState(() {
                            color = Colors.red;
                            tempCountry = '';
                          });
                        }
                      },
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
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: color,
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Country List',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 2,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  //color: Colors.black12,

                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 250),
                  child: FutureBuilder(
                      future: getCountryData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return Card(
                                    margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
                                    elevation: 2,
                                    child: ListTile(
                                      onTap: () {
                                        toCountryPage(
                                            snapshot.data[index].shortName,
                                            snapshot.data[index]);
                                      },
                                      title: Text(
                                          snapshot.data[index].countryName),
                                      leading: Image.network(
                                        snapshot.data[index].countryUrl,
                                        height: 40,
                                        width: 40,
                                      ),
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
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ));
  }

  Future<List<CountryData>> getCountryData() async {
    if (!load) {
      await allCountryList.getAllCountryData();
      countryDataList = allCountryList.countryList;

      setState(() {
        load = true;
        indiaData = allCountryList.indiaData;
        name = allCountryList.indiaData.shortName;
      });
      return countryDataList;
    } else if (search) {
      return searchCountry(_controller.text);
    } else
      return countryDataList;
  }

  List<CountryData> searchCountry(String name) {
    List<CountryData> tempCountryList = countryDataList, temp = [];
    for (var country in tempCountryList) {
      if (name.toLowerCase() ==
          country.countryName.toLowerCase().substring(0, name.length)) {
        temp.add(country);
      }
    }
    return temp;
  }

  void toCountryPage(String countryName, var data) {
    Navigator.push(
        context,
        SlideRoute(
            widget: CountryPage(
          countryName: countryName,
          data: data,
        )));
  }
}
