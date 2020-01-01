import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../../../../data/homeScreenData/answerData/answersList.dart';
import '../../../../../../../../data/homeScreenData/answerData/validateAnswers/checkNoEmptyAnswers.dart';
import '../../../../../../../../data/homeScreenData/answerData/validateAnswers/checkValidRange.dart';
import '../../../../../../../../data/homeScreenData/answerData/finalResult.dart';
import '../../../../../../../../data/homeScreenData/answerData/convertToJSON/convertToJSON.dart';
import '../../../messageDialog/messageDialog.dart';
import '../../../../../../../../services/uploadJSON/uploadJSON.dart';
import '../../../../../../../../data/loginScreenData/userInfo.dart';
import '../../../../../../../../data/homeScreenData/answerData/previousAnswer/previousAnswer.dart';

class ListTileSubmitButton extends StatefulWidget {
  @override
  State<ListTileSubmitButton> createState() => ListTileSubmitButtonState();
}

class ListTileSubmitButtonState extends State<ListTileSubmitButton> {

  static bool submitting = false;

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new SizedBox(height: 5.0),
        new Container(
          width: MediaQuery.of(context).size.width - 20,
          child: new RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: new Text(setButtonValue(submitting)),
            onPressed: setButtonState(submitting, context),
          ),
        ),
        new SizedBox(height: 7.0)
      ],
    );
  }

  setButtonState(bool submit, BuildContext context) {
    if(submit) {
      return null;
    } else {
      return () async {
        submitting = true;
        setState(() {});
        bool validatePassed = validateAnswers(context);
        if(validatePassed)
          await uploadAnswers(context);
        submitting = false;
        setState(() {});
      };
    }
  }

  setButtonValue(bool submit) {
    if(submit) {
      return 'Submitting';
    } else {
      return 'Submit';
    }
  }

  uploadAnswers(BuildContext context) async {
    List resultsList = FinalResult().getResults();

    await MessageDialog().showResult(context, 'Results', getMessageText(resultsList[3]), 'Action',
        'I will prescribe antibiotics for my patient.', true);

    Map json = await JSONConverter().buildJSON(resultsList[6], getPromptText(resultsList[2]),
        resultsList[5], getPromptText(resultsList[1]), resultsList[4], getPromptText(resultsList[0]),
        getPromptText(resultsList[3]));

    int code = await Upload().upload(json);
    print('Code: ' + code.toString());

    AnswersList.resetList();
    if(code == 200)
      await MessageDialog().showFinalDecision(context, 'Upload successful!', 'Your entry has been successfully recorded!', false);
    else if(code == 20001)
      await MessageDialog().showFinalDecision(context, 'Save successful!', 'Data has been saved locally. '
          'Data will be uploaded to server when an internet connection is detected!', false);
    else if(code == -999) {
      Navigator.popAndPushNamed(context, '/loginScreen');
      UserCredentials().deleteUser();
      PreviousAnswer().clearPreviousAnswer();
      await MessageDialog().showFinalDecision(context, 'Error!', 'User account does not exist! '
          'Please sign in with a valid user account!'
          '\n'
          'For assistance, please contact the administrator at weixiang_lian@ttsh.com.sg', false);
    } else
      await MessageDialog().showFinalDecision(context, 'Upload failed!', 'An error has occurred!', false);
  }

  Widget getMessageText(bool prescribeAntibiotics) {
    if(prescribeAntibiotics)
      return RichText(
        text: TextSpan(
          text: 'Please ',
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            TextSpan(text: 'review', style: TextStyle(color: Colors.red, decoration: TextDecoration.underline)),
            TextSpan(text: ' the need for antibiotics for your patient'),
          ],
        ),
      );
    return RichText(
      text: TextSpan(
        text: 'Based on the results from 3 validated models, antibiotics is ',
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(text: 'not recommended', style: TextStyle(color: Colors.red, decoration: TextDecoration.underline)),
          TextSpan(text: ' for your patient'),
        ],
      ),
    );
  }

  String getPromptText(bool prescribeAntibiotics) {
    if(prescribeAntibiotics)
      return 'Please review the need for antibiotics for your patient';
    return 'Based on the results from 3 validated models, antibiotics is not recommended for your patient';
  }

  validateAnswers(BuildContext context) {
    bool allAnswersFilled = CheckNoEmptyAnswers().checkAnswers();
    if(!allAnswersFilled) {
      MessageDialog().build(context, 'Warning', 'Some responses are empty!');
      return false;
    } else {
      bool answersRangeValid = CheckAnswersRange().checkInValidRange();
      if(!answersRangeValid) {
        MessageDialog().build(context, 'Warning', 'Some answers are outside the valid range!');
        return false;
      }
    }
    AnswersList().savePreviousAnswers();
    return true;
  }
}