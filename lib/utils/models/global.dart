import 'package:covidtrack/utils/services/network.dart';

class GlobalData {
  int totalConfirmed,
      totalRecovered,
      totalDeaths,
      totalActive,
      newConfirmed,
      newDeaths,
      newRecovered,
      newActive;

  GlobalData(
      {this.totalConfirmed,
      this.totalDeaths,
      this.totalRecovered,
      this.totalActive,
      this.newDeaths,
      this.newRecovered,
      this.newConfirmed,
      this.newActive});

  static final String _apiUrl = 'https://api.covid19api.com/summary';

  getGlobalData() async {
    NetworkHelper _networkHelper = NetworkHelper(_apiUrl);
    var globalData = await _networkHelper.getData();
    var data = globalData['Global'];
    this.totalConfirmed = data['TotalConfirmed'];
    this.totalDeaths = data['TotalDeaths'];
    this.totalRecovered = data['TotalRecovered'];
    this.newConfirmed = data['NewConfirmed'];
    this.newRecovered = data['NewRecovered'];
    this.newDeaths = data['NewDeaths'];
    this.totalActive =
        this.totalConfirmed - (this.totalRecovered + this.totalDeaths) >= 0
            ? this.totalConfirmed - (this.totalRecovered + this.totalDeaths)
            : 0;
    this.newActive =
        this.newConfirmed - (this.newRecovered + this.newDeaths) >= 0
            ? this.newConfirmed - (this.newRecovered + this.newDeaths)
            : 0;

    return this;
  }
}
