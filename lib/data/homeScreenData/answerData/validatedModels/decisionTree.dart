import '../answersList.dart';

class DecisionTree {
  double getScore() {
    double highestTemp = double.tryParse(AnswersList.getAnswer(8));
    int highestBPM = int.tryParse(AnswersList.getAnswer(9));
    double score;

    if (highestTemp < 37.25) {
      score = 0.737160120845921;
    } else if (highestTemp >= 38.85) {
      score = 0.2;
    } else {
      if (highestBPM >= 102.5) {
        score = 0.266666667;
      } else {
        score = 0.612244898;
      }
    }

    return score;
  }

  int getValue(bool value) {
    if(value)
      return 1;
    return 0;
  }
}