import 'package:covidtrack/utils/models/state_data.dart';
import 'package:covidtrack/utils/services/network.dart';

class StateList {
  List<StateData> stateList;
  StateData totalData;
  static final String _apiUrl = 'https://api.covid19india.org/data.json';

  StateList({this.stateList, this.totalData});

  getAllStateData() async {
    NetworkHelper _networkHelper = NetworkHelper(_apiUrl);
    var data = await _networkHelper.getData();
    var statesArray = data['statewise'];
    this.stateList = [];
    var total = statesArray[0];
    this.totalData = StateData(lastUpdated: total['lastupdatedtime']);
    this.totalData.name = total['state'];
    this.totalData.code = total['statecode'];
    this.totalData.totalConfirmed = int.parse(total['confirmed']);
    this.totalData.totalActive = int.parse(total['active']);
    this.totalData.totalRecovered = int.parse(total['recovered']);
    this.totalData.totalDeaths = int.parse(total['deaths']);
    this.totalData.newConfirmed = int.parse(total['deltaconfirmed']);
    this.totalData.newDeaths = int.parse(total['deltadeaths']);
    this.totalData.newRecovered = int.parse(total['deltarecovered']);
    this.totalData.newActive = this.totalData.newConfirmed -
                (this.totalData.newRecovered + this.totalData.newDeaths) >=
            0
        ? this.totalData.newConfirmed -
            (this.totalData.newRecovered + this.totalData.newDeaths)
        : 0;

    for (int i = 1; i < statesArray.length; i++) {
      StateData stateData =
          StateData(lastUpdated: statesArray[i]['lastupdatedtime']);

      stateData.code = statesArray[i]['statecode'];

      stateData.name = statesArray[i]['state'];

      stateData.totalRecovered = int.parse(statesArray[i]['recovered']);

      stateData.totalActive = int.parse(statesArray[i]['active']);
      stateData.totalConfirmed = int.parse(statesArray[i]['confirmed']);
      stateData.totalDeaths = int.parse(statesArray[i]['deaths']);

      stateData.newDeaths = int.parse(statesArray[i]['deltadeaths']);
      stateData.newConfirmed = int.parse(statesArray[i]['deltaconfirmed']);
      stateData.newRecovered = int.parse(statesArray[i]['deltarecovered']);
      stateData.newActive = int.parse(statesArray[i]['deltaconfirmed']) -
          (int.parse(statesArray[i]['deltarecovered']) +
              int.parse(statesArray[i]['deltadeaths']));
      if (stateData.totalConfirmed != 0 && stateData.totalRecovered != 0)
        this.stateList.add(stateData);
    }

    return this;
  }

  getMost(String type) async {
    StateData _state = StateData();
    _state = this.stateList[0];
    switch (type) {
      case 'cases':
        for (int i = 1; i < this.stateList.length; i++) {
          if (_state.totalConfirmed < this.stateList[i].totalConfirmed)
            _state = this.stateList[i];
        }
        break;

      case 'recovered':
        for (int i = 1; i < this.stateList.length; i++) {
          if (_state.totalRecovered < this.stateList[i].totalRecovered)
            _state = this.stateList[i];
        }
        break;

      case 'deaths':
        for (int i = 1; i < this.stateList.length; i++) {
          if (_state.totalDeaths < this.stateList[i].totalDeaths)
            _state = this.stateList[i];
        }
        break;
    }
    return _state;
  }

  sortStateList(String type) {
    var stateArray = this.stateList;
    for (int i = 0; i < stateArray.length; i++) {
      for (int j = 0; j < (stateArray.length - i - 1); j++) {
        if (stateArray[j].getTypes(type) < stateArray[j + 1].getTypes(type)) {
          var tempState = stateArray[j];
          stateArray[j] = stateArray[j + 1];
          stateArray[j + 1] = tempState;
        }
      }
    }
    return stateArray;
  }
}
