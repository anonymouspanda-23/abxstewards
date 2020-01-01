import 'package:flutter/cupertino.dart';

import 'dropDownMenu/months.dart';
import 'dropDownMenu/races.dart';

class QuestionsList {
  static final QuestionsList _questionsList = QuestionsList._internal();
  factory QuestionsList() {
    return _questionsList;
  }
  QuestionsList._internal();

  static DateTime _currentDateTime = new DateTime.now();
  static TextEditingController ageController;

  static List<Map> questionsData = <Map>[
    { // Question 1
      'question': 'Visit Month',
      'type': 'dropdown',
      'autofill': true,
      'autofill_value': Months().getCurrentMonth(_currentDateTime.month - 1),
      'options': Months.monthsList,
      'hintText': 'Select a month'
    },
    { // Question 2
      'question': 'Age',
      'type': 'integer',
      'max_length': 3,
      'min_value': 21,
      'max_value': 120,
      'warning': 'Valid range: 21 to 120',
    },
    { // Question 3
      'question': 'Gender',
      'type': 'binary',
      'autofill': true,
      'autofill_value': false,
      true: 'Male',
      false: 'Female'
    },
    { // Question 4
      'question': 'Ethnicity',
      'type': 'dropdown',
      'autofill': true,
      'autofill_value': Races().getDefaultRace(),
      'options': Races.racesList,
      'hintText': 'Select a race'
    },
    { // Question 5
      'question': 'History Of Cancer',
      'type': 'binary',
      'autofill': true,
      'autofill_value': false,
      true: 'Yes',
      false: 'No'
    },
    { // Question 6
      'question': 'Giddiness',
      'type': 'binary',
      'autofill': true,
      'autofill_value': false,
      true: 'Yes',
      false: 'No'
    },
    { // Question 7
      'question': 'Fever',
      'type': 'binary',
      'autofill': true,
      'autofill_value': false,
      true: 'Yes',
      false: 'No',
    },
    { // Question 8
      'question': 'Shortness Of Breath',
      'type': 'binary',
      'autofill': true,
      'autofill_value': false,
      true: 'Yes',
      false: 'No',
    },
    { // Question 9
      'question': 'Highest Body Temperature',
      'description': '(°C)',
      'type': 'decimal',
      'max_length': 4,
      'min_value': 34.0,
      'max_value': 46.5,
      'warning': 'Valid range: 34.0 to 46.5',
    },
    { // Question 10
      'question': 'Highest Pulse Rate',
      'description': '(Beats Per Minute)',
      'type': 'integer',
      'max_length': 3,
      'min_value': 30,
      'max_value': 200,
      'warning': 'Valid range: 30 to 200',
    },
    { // Question 11
      'question': 'Is this the same patient as the one in the previous entry?',
      'type': 'binary',
      'autofill': true,
      'autofill_value': false,
      true: 'Yes',
      false: 'No'
    },
    { // Question 12
      'question': 'Patient Initials',
      'type': 'text',
      'max_length': 4,
      'placeholder': 'XXXX'
    },
    {
      'type': 'submit'
    }
  ];
}