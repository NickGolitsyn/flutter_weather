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
        return 'London';
      case CityEnum.paris:
        return 'Paris';
      case CityEnum.newyork:
        return 'New York';
    }
  }
}
