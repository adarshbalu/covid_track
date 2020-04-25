class DistrictData {
  int totalActive,
      totalRecovered,
      totalDeaths,
      totalConfirmed,
      newActive,
      newRecovered,
      newDeaths,
      newConfirmed;
  String name, stateCode, stateName;

  DistrictData(
      {this.totalConfirmed,
      this.totalDeaths,
      this.totalRecovered,
      this.name,
      this.newDeaths,
      this.newRecovered,
      this.newConfirmed,
      this.newActive,
      this.totalActive,
      this.stateCode,
      this.stateName});

  setDistrictData(var data) async {
    this.totalConfirmed = data.totalConfirmed;
    this.totalDeaths = data.totalDeaths;
    this.totalRecovered = data.totalRecovered;
    this.newConfirmed = data.newConfirmed;
    this.newRecovered = data.newRecovered;
    this.newDeaths = data.newDeaths;
    this.newActive =
        data.newConfirmed - (data.newRecovered + data.newDeaths) >= 0
            ? data.newConfirmed - (data.newRecovered + data.newDeaths)
            : 0;
    this.totalActive = data.totalActive;
    this.name = data.name;
    this.stateCode = data.stateCode;
    this.stateName = data.stateName;
    return this;
  }

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
}
