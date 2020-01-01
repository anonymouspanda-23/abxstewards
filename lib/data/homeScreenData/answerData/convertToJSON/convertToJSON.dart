import 'package:intl/intl.dart';
import 'dart:io';

import '../answersList.dart';
import '../../questionData/dropDownMenu/months.dart';
import '../../../loginScreenData/userInfo.dart';

class JSONConverter {

  buildJSON(double treeProb, String treeRecc, double lassoProb, String lassoRecc, double logProb, String logRecc, String finalRecc) async {
    int visitMonth = Months().getMonth(AnswersList.getAnswer(0)) + 1;
    int age = int.tryParse(AnswersList.getAnswer(1));
    int gender = getValue(AnswersList.getAnswer(2));
    int ethnicity = getEthnicity(AnswersList.getAnswer(3));
    int hasCancer = getValue(AnswersList.getAnswer(4));
    int giddy = getValue(AnswersList.getAnswer(5));
    int fever = getValue(AnswersList.getAnswer(6));
    int sob = getValue(AnswersList.getAnswer(7));
    double highestTemp = double.tryParse(AnswersList.getAnswer(8));
    int highestBPM = int.tryParse(AnswersList.getAnswer(9));
    int samePatient = getValue(AnswersList.getAnswer(10));
    String initials = AnswersList.getAnswer(11);
    int antibiotics = getValue(AnswersList.prescribedAntibiotics);
    String doctorName = await UserCredentials().getUsername();
    var dateTime = new DateTime.now();

    String systemOS = 'Error: Source Unavailable';
    if(Platform.isWindows)
      systemOS = 'Windows';
    else if(Platform.isMacOS)
      systemOS = 'Mac OSX';
    else if(Platform.isLinux)
      systemOS = 'Linux';
    else if(Platform.isAndroid)
      systemOS = 'Android';
    else if(Platform.isIOS)
      systemOS = 'iOS';
    else if(Platform.isFuchsia)
      systemOS = 'Google Fuchsia';

    Map json = {
      "results": {
        "decision_probability": treeProb,
        "decision_recommendation": treeRecc,
        "lasso_probability": lassoProb,
        "lasso_recommendation": lassoRecc,
        "logistic_probability": logProb,
        "logistic_recommendation": logRecc,
        "overall_recommendation": finalRecc,
        "timestamp": new DateFormat("yyyy-MM-dd HH:mm:ss").format(dateTime),
        "prescribed_antibiotics": antibiotics,
      },
      "variables": {
        "age": age,
        "shortness_of_breath": sob,
        "ethnicity": ethnicity,
        "fever": fever,
        "gender": gender,
        "highest_body_temperature": highestTemp,
        "highest_pulse_rate": highestBPM,
        "history_of_cancer": hasCancer,
        "presence_of_giddiness": giddy,
        "visit_month": visitMonth,
        "username": doctorName,
        "same_patient": samePatient,
        "patient_initials": initials,
        "source": systemOS,
      }
    };
    return json;
  }

  getValue(bool value) {
    if(value)
      return 1;
    return 0;
  }

  getEthnicity(String value) {
    if(value == 'Indian')
      return 1;
    return 0;
  }
}