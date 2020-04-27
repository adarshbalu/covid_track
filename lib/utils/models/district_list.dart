import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:covidtrack/utils/models/district.dart';

class DistrictList {
  List<DistrictData> districtList;
  static final String _apiUrl =
      'https://api.covid19india.org/v2/state_district_wise.json';

  DistrictList({this.districtList});

  getAllDistrictData(String stateName) async {
    http.Response response = await http.get(_apiUrl);
    if (response.statusCode == 200) {
      var data = response.body;
      var statesArray = jsonDecode(data);
      this.districtList = [];

      for (var state in statesArray) {
        DistrictData districtData = DistrictData(
          stateName: state['state'],
          stateCode: state['statecode'],
        );
        var districtArray = state['districtData'];
        for (var district in districtArray) {
          districtData.name = district['district'];
          districtData.totalDeaths = district['deceased'];
          districtData.totalActive = district['active'];
          districtData.totalConfirmed = district['confirmed'];
          districtData.totalRecovered = district['recovered'];
          districtData.newConfirmed = district['delta']['confirmed'];
          districtData.newDeaths = district['delta']['deceased'];
          districtData.newRecovered = district['delta']['recovered'];
          districtData.newActive = districtData.newConfirmed -
              (districtData.newRecovered + districtData.newDeaths);
          if (stateName == state['state'] &&
              district['district'] != 'Unknown') {
            if (!(districtData.totalConfirmed == 0))
              this.districtList.add(districtData);
          }

          districtData = DistrictData(
            stateName: state['state'],
            stateCode: state['statecode'],
          );
        }
      }
    }
    return this;
  }

//  getMost(String type) async {
//    StateData _state = StateData();
//    _state = this.stateList[0];
//    switch (type) {
//      case 'cases':
//        for (int i = 1; i < this.stateList.length; i++) {
//          if (_state.totalConfirmed < this.stateList[i].totalConfirmed)
//            _state = this.stateList[i];
//        }
//        break;
//
//      case 'recovered':
//        for (int i = 1; i < this.stateList.length; i++) {
//          if (_state.totalRecovered < this.stateList[i].totalRecovered)
//            _state = this.stateList[i];
//        }
//        break;
//
//      case 'deaths':
//        for (int i = 1; i < this.stateList.length; i++) {
//          if (_state.totalDeaths < this.stateList[i].totalDeaths)
//            _state = this.stateList[i];
//        }
//        break;
//    }
//    return _state;
//  }
//
//  sortStateList(String type) {
//    var stateArray = this.stateList;
//    for (int i = 0; i < stateArray.length; i++) {
//      for (int j = 0; j < (stateArray.length - i - 1); j++) {
//        if (stateArray[j].getTypes(type) < stateArray[j + 1].getTypes(type)) {
//          var tempState = stateArray[j];
//          stateArray[j] = stateArray[j + 1];
//          stateArray[j + 1] = tempState;
//        }
//      }
//    }
//    return stateArray;
//  }
}
