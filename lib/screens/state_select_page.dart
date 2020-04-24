import 'package:covidtrack/screens/state_page.dart';
import 'package:covidtrack/utils/models/state_data.dart';
import 'package:covidtrack/utils/models/state_list.dart';
import 'package:covidtrack/utils/navigation_transition.dart';
import 'package:covidtrack/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StateSelectPage extends StatefulWidget {
  @override
  _StateSelectPageState createState() => _StateSelectPageState();
}

class _StateSelectPageState extends State<StateSelectPage> {
  StateList stateList;
  TextEditingController _controller = TextEditingController();
  Color color = Colors.red;
  bool search = false;
  String url = '', name;
  StateData stateData;

  List<StateData> stateDataList;
  bool load = false;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    stateList = StateList(stateList: [], totalData: StateData());
    super.initState();
  }

  String tempState;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomMenu(null),
        body: SafeArea(
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AppHeader(
                headerText: 'States',
              ),
              SizedBox(
                height: 20,
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
                          for (var state in stateDataList) {
                            if (state.name.toLowerCase() ==
                                value.toLowerCase()) {
                              setState(() {
                                search = true;
                                tempState = state.name;
                              });
                            }
                          }
                          if (!search) {
                            setState(() {
                              color = Colors.red;
                              tempState = '';
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
                          helperText: 'Enter Name of State',
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
                height: 15,
              ),
              Divider(),
              SizedBox(
                height: 15,
              ),
              Text(
                'States List',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                padding: EdgeInsets.only(top: 8, bottom: 8),
                decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(color: Colors.grey, width: 10),
                      right: BorderSide(color: Colors.grey, width: 10)),
                  // borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height / 2,
                      maxHeight: MediaQuery.of(context).size.height / 1.8),
                  child: FutureBuilder(
                      future: getStateData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return Card(
                                    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    elevation: 2,
                                    child: ListTile(
                                      onTap: () {
                                        toStatePage(snapshot.data[index].name,
                                            snapshot.data[index]);
                                      },
                                      title: Text(snapshot.data[index].name),
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

  Future<List<StateData>> getStateData() async {
    if (!load) {
      await stateList.getAllStateData();
      stateDataList = stateList.stateList;
      stateDataList
          .sort((StateData a, StateData b) => a.name.compareTo(b.name));
      setState(() {
        load = true;
      });
      return stateDataList;
    } else if (search) {
      return searchState(_controller.text);
    } else
      return stateDataList;
  }

  List<StateData> searchState(String name) {
    List<StateData> tempStateList = stateDataList, temp = [];
    for (var state in tempStateList) {
      if (name.toLowerCase() ==
          state.name.toLowerCase().substring(0, name.length)) {
        temp.add(state);
      }
    }
    return temp;
  }

  void toStatePage(String stateName, var data) {
    Navigator.push(
        context,
        SlideRoute(
            widget: StatePage(
          stateName: stateName,
          data: data,
        )));
  }
}
