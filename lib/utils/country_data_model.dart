class CountryData {
  int totalConfirmed, totalRecovered, totalDeath, totalActive;
  int newConfirmed, newRecovered, newDeath, newActive;
  String countryName, shortName, countryCode, countryUrl;
  CountryData(
      {this.totalConfirmed,
      this.totalDeath,
      this.totalRecovered,
      this.totalActive,
      this.countryName,
      this.shortName,
      this.countryUrl,
      this.countryCode,
      this.newRecovered,
      this.newConfirmed,
      this.newActive,
      this.newDeath});

  int getTypes(String type) {
    switch (type) {
      case 'cases':
        return this.totalConfirmed;
        break;
      case 'recovered':
        return this.totalRecovered;
        break;
      case 'deaths':
        return this.totalDeath;
        break;
    }
  }
}
