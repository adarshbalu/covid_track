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
  ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
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
        bottomNavigationBar: BottomMenu(),
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
                height: MediaQuery.of(context).size.height / 40,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 4.5,
                  ),
                  Expanded(
                    child: Container(
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
                          fontSize: 22,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          helperText: 'Enter Name of Country',
                          helperStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
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
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 4.5,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'Country List',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
                  ),
                  Icon(Icons.arrow_downward)
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 100,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                padding: EdgeInsets.only(top: 8, bottom: 0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height / 2.3,
                      maxHeight: MediaQuery.of(context).size.height / 2.2),
                  child: FutureBuilder(
                      future: getCountryData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Scrollbar(
                            controller: _scrollController,
                            child: ListView.builder(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                      margin:
                                          EdgeInsets.fromLTRB(20, 10, 20, 10),
                                      elevation: 4,
                                      child: ListTile(
                                        onTap: () {
                                          toCountryPage(
                                              snapshot.data[index].shortName,
                                              snapshot.data[index]);
                                        },
                                        trailing: Padding(
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: Icon(Icons.arrow_right),
                                        ),
                                        subtitle: Text('Cases : ' +
                                            snapshot.data[index].totalConfirmed
                                                .toString()),
                                        title: Text(
                                            snapshot.data[index].countryName),
                                        leading: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle),
                                          child: Image.network(
                                            snapshot.data[index].countryUrl,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ));
                                }),
                          );
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
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Displays countries with minimum one confirmed case.',
                    textAlign: TextAlign.center,
                  ),
                ),
                height: 30,
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
