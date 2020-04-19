import 'package:covidtrack/utils/models/country.dart';
import 'package:covidtrack/utils/services/network.dart';

class CountryList {
  List<CountryData> countryList;
  CountryData indiaData;
  static final String _apiUrl = 'https://api.covid19api.com/summary';

  CountryList({this.countryList, this.indiaData});

  getAllCountryData() async {
    countryList = List();
    NetworkHelper _networkHelper = NetworkHelper(_apiUrl);
    var data = await _networkHelper.getData();
    var countryArray = data['Countries'];

    for (var country in countryArray) {
      CountryData countryData = CountryData(
          totalRecovered: 0,
          totalActive: 0,
          totalConfirmed: 0,
          totalDeaths: 0,
          countryName: '',
          countryUrl: '',
          countryCode: '',
          newDeaths: 0,
          newConfirmed: 0,
          newRecovered: 0,
          newActive: 0,
          shortName: '');

      countryData.countryName = country['Country'];
      countryData.totalConfirmed = country['TotalConfirmed'];
      countryData.totalDeaths = country['TotalDeaths'];
      countryData.totalRecovered = country['TotalRecovered'];
      countryData.newConfirmed = country['NewConfirmed'];
      countryData.newDeaths = country['NewDeaths'];
      countryData.newRecovered = country['NewRecovered'];
      countryData.newActive = countryData.newConfirmed -
          (countryData.newRecovered - countryData.newDeaths);
      countryData.totalActive = countryData.totalConfirmed -
          (countryData.totalRecovered - countryData.totalDeaths);
      countryData.countryName = country['Country'];
      countryData.shortName = country['Slug'];
      countryData.countryCode = country['CountryCode'];
      countryData.countryUrl =
          'http://www.geognos.com/api/en/countries/flag/${countryData.countryCode.toUpperCase()}.png';
      if (countryData.shortName == 'india') {
        this.indiaData = countryData;
      }
      this.countryList.add(countryData);
    }
    return this.countryList;
  }

  getMost(String type) async {
    CountryData _countryData;
    _countryData = this.countryList[0];
    switch (type) {
      case 'cases':
        for (int i = 1; i < this.countryList.length; i++) {
          if (_countryData.totalConfirmed < this.countryList[i].totalConfirmed)
            _countryData = this.countryList[i];
        }
        break;

      case 'recovered':
        for (int i = 1; i < this.countryList.length; i++) {
          if (_countryData.totalRecovered < this.countryList[i].totalRecovered)
            _countryData = this.countryList[i];
        }
        break;

      case 'deaths':
        for (int i = 1; i < this.countryList.length; i++) {
          if (_countryData.totalDeaths < this.countryList[i].totalDeaths)
            _countryData = this.countryList[i];
        }
        break;
    }
    return _countryData;
  }

  sortCountryList(String type) {
    var countryArray = this.countryList;
    for (int i = 0; i < countryArray.length; i++) {
      for (int j = 0; j < (countryArray.length - i - 1); j++) {
        if (countryArray[j].getTypes(type) <
            countryArray[j + 1].getTypes(type)) {
          var tempCountry = countryArray[j];
          countryArray[j] = countryArray[j + 1];
          countryArray[j + 1] = tempCountry;
        }
      }
    }
    return countryArray;
  }
}
