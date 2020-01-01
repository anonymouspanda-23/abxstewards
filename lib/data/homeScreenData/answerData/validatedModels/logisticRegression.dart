import 'dart:math';
import '../answersList.dart';

class LogisticRegression {
  double getScore() {
    int age = int.tryParse(AnswersList.getAnswer(1));
    int hasFever = getValue(AnswersList.getAnswer(6));
    int shortnessOfBreath = getValue(AnswersList.getAnswer(7));
    int isGiddy = getValue(AnswersList.getAnswer(5));
    double highestTemp = double.tryParse(AnswersList.getAnswer(8));
    int highestBPM = int.tryParse(AnswersList.getAnswer(9));
    double score;

    score = 21.21197724 +
        (-0.01921583 * age) + (-0.60659876 * hasFever) + (0.55104701 * shortnessOfBreath) +
        (1.34265642 * isGiddy) + (-0.45608855 * highestTemp) + (-0.02907569 * highestBPM);

    score = exp(score);
    score = score / (1 + score);

    return score;
  }

  int getValue(bool value) {
    if(value)
      return 1;
    return 0;
  }
}