import '../../answerData/answersList.dart';
import '../../questionData/questionsData.dart';

class CheckAnswersRange {
  bool checkInValidRange() {
    for(int index = 0; index < QuestionsList.questionsData.length; index++) {
      if(QuestionsList.questionsData[index]['type'] == 'integer' || QuestionsList.questionsData[index]['type'] == 'decimal') {
        if(QuestionsList.questionsData[index]['parent_index'] != null) {
          int parentIndex = QuestionsList.questionsData[index]['parent_index'];
          if(QuestionsList.questionsData[parentIndex]['child_showing'] == false)
            continue;
          else {
            if(double.tryParse(AnswersList.getAnswer(index)) < QuestionsList.questionsData[index]['min_value']
                || double.tryParse(AnswersList.getAnswer(index)) > QuestionsList.questionsData[index]['max_value']) {
              return false;
            }
          }
        } else {
          if(double.tryParse(AnswersList.getAnswer(index)) < QuestionsList.questionsData[index]['min_value']
            || double.tryParse(AnswersList.getAnswer(index)) > QuestionsList.questionsData[index]['max_value']) {
            return false;
          }
        }
      }
    }
    return true;
  }
}