class Races {
  static final List<String> racesList = <String>[
    'Chinese',
    'Malay',
    'Indian',
    'Others',
  ];

  String getDefaultRace() {
    return racesList[0];
  }
}