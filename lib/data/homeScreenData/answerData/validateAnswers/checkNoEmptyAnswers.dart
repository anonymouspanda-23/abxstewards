import '../../answerData/answersList.dart';
import '../../questionData/questionsData.dart';

class CheckNoEmptyAnswers {
  bool checkAnswers() {
    for(int index = 0; index < AnswersList.getAnswersLength(); index++) {
      if(QuestionsList.questionsData[index]['parent_index'] != null) {
        int parentIndex = QuestionsList.questionsData[index]['parent_index'];
        if(QuestionsList.questionsData[parentIndex]['child_showing']) {
          if(AnswersList.getAnswer(index) == null)
            return false;
        } else {
          continue;
        }
      } else {
        if(AnswersList.getAnswer(index) == null)
          return false;
      }
    }
    return true;
  }
}