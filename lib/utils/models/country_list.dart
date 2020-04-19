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
}
