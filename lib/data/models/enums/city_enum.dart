enum CityEnum {
  moscow,
  london,
  paris,
  newyork;

  String get cityString {
    switch (this) {
      case CityEnum.moscow:
        return 'Moscow';
      case CityEnum.london:
        return 'Paris';
      case CityEnum.paris:
        return 'London';
      case CityEnum.newyork:
        return 'New York';
    }
  }
}
