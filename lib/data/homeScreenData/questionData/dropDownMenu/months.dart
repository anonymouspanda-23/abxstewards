class Months {
  static final List<String> monthsList = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  String getCurrentMonth(int month) {
    return monthsList[month];
  }

  int getMonth(String month) {
    for(int i = 0; i < monthsList.length; i++) {
      if(month == monthsList[i])
        return i;
    }
    return 0;
  }
}