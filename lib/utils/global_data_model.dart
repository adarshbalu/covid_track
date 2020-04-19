import 'package:covidtrack/utils/network.dart';

class GlobalData {
  int totalConfirmed,
      totalRecovered,
      totalDeath,
      totalActive,
      newConfirmed,
      newDeaths,
      newRecovered,
      newActive;

  GlobalData(
      {this.totalConfirmed,
      this.totalDeath,
      this.totalRecovered,
      this.totalActive,
      this.newDeaths,
      this.newRecovered,
      this.newConfirmed,
      this.newActive});

  static final String _apiUrl = 'https://api.covid19api.com/summary';

  getGlobalData() async {
    NetworkHelper networkHelper = NetworkHelper(_apiUrl);
    var globalData = await networkHelper.getData();
    var data = globalData['Global'];
    this.totalConfirmed = data['TotalConfirmed'];
    this.totalDeath = data['TotalDeaths'];
    this.totalRecovered = data['TotalRecovered'];
    this.newConfirmed = data['NewConfirmed'];
    this.newRecovered = data['NewRecovered'];
    this.newDeaths = data['NewDeaths'];
    this.totalActive =
        this.totalConfirmed - (this.totalRecovered + this.totalDeath);
    this.newActive = this.newConfirmed - (this.newRecovered + this.newDeaths);

    return this;
  }
}
