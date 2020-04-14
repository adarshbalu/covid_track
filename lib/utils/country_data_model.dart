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
}
