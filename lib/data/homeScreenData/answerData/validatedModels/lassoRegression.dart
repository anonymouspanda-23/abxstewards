import 'dart:math';
import '../answersList.dart';

class LassoRegression {
  double getScore() {
    int isIndian = getValueFromString(AnswersList.getAnswer(3));
    int hasCancer = getValue(AnswersList.getAnswer(4));
    int hasFever = getValue(AnswersList.getAnswer(6));
    int isGiddy = getValue(AnswersList.getAnswer(5));
    double highestTemp = double.tryParse(AnswersList.getAnswer(8));
    int highestBPM = int.tryParse(AnswersList.getAnswer(9));
    double score;

    score = 17.55965307 +
        (-0.087582939 * isIndian) + (-0.182490954 * hasCancer) + (-0.247903983 * hasFever) +
        (0.008771653 * isGiddy) + (-0.422987865 * highestTemp) + (-0.011455751 * highestBPM);

    score = exp(score);
    score = score / (1 + score);

    return score;
  }

  int getValueFromString(String value) {
    if(value == 'Indian')
      return 1;
    return 0;
  }

  int getValue(bool value) {
    if(value)
      return 1;
    return 0;
  }
}