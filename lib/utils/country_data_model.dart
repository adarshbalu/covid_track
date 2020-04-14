class CountryData {
  int totalConfirmed, totalRecovered, totalDeath, totalActive;
  String countryName, shortName, countryCode, countryUrl;
  CountryData(
      {this.totalConfirmed,
      this.totalDeath,
      this.totalRecovered,
      this.totalActive,
      this.countryName,
      this.shortName,
      this.countryUrl,
      this.countryCode});
}
