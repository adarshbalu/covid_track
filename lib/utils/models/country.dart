class CountryData {
  int totalConfirmed,
      totalRecovered,
      totalDeaths,
      totalActive,
      newConfirmed,
      newRecovered,
      newDeaths,
      newActive;
  String countryName, shortName, countryCode, countryUrl;

  CountryData(
      {this.totalConfirmed,
      this.totalDeaths,
      this.totalRecovered,
      this.totalActive,
      this.countryName,
      this.shortName,
      this.countryUrl,
      this.countryCode,
      this.newRecovered,
      this.newConfirmed,
      this.newActive,
      this.newDeaths});

  getTypes(String type) {
    switch (type) {
      case 'cases':
        return this.totalConfirmed;
        break;
      case 'recovered':
        return this.totalRecovered;
        break;
      case 'deaths':
        return this.totalDeaths;
        break;
    }
  }

  getCountryData(var data) async {
//    this.totalConfirmed = data['TotalConfirmed'];
//    this.totalDeaths = data['TotalDeaths'];
//    this.totalRecovered = data['TotalRecovered'];
//    this.newConfirmed = data['NewConfirmed'];
//    this.newRecovered = data['NewRecovered'];
//    this.newDeaths = data['NewDeaths'];
//    this.totalActive =
//        this.totalConfirmed - (this.totalRecovered + this.totalDeaths);
//    this.newActive = this.newConfirmed - (this.newRecovered + this.newDeaths);
//
//    this.countryName = data['Country'];
//    this.countryCode = data['CountryCode'];
//    this.countryUrl =
//        'http://www.geognos.com/api/en/countries/flag/${this.countryCode.toUpperCase()}.png';
//    this.shortName = data['Slug'];

    this.totalConfirmed = data.totalConfirmed;
    this.totalDeaths = data.totalDeaths;
    this.totalRecovered = data.totalRecovered;
    this.newConfirmed = data.newConfirmed;
    this.newRecovered = data.newRecovered;
    this.newDeaths = data.newDeaths;
    this.totalActive =
        this.totalConfirmed - (this.totalRecovered + this.totalDeaths);
    this.newActive = this.newConfirmed - (this.newRecovered + this.newDeaths);

    this.countryName = data.countryName;
    this.countryCode = data.countryCode;
    this.countryUrl =
        'http://www.geognos.com/api/en/countries/flag/${this.countryCode.toUpperCase()}.png';
    this.shortName = data.shortName;
    return this;
  }
}
