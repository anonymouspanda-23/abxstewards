import 'validatedModels/lassoRegression.dart';
import 'validatedModels/logisticRegression.dart';
import 'validatedModels/decisionTree.dart';

class FinalResult {
  List getResults() {
    double lassoRegressionScore = LassoRegression().getScore();
    double logisticRegressionScore = LogisticRegression().getScore();
    double decisionTreeScore = DecisionTree().getScore();

    bool lassoGiveAntibiotics = false;
    bool logisticGiveAntibiotics = false;
    bool decisionGiveAntibiotics = false;

    bool prescribeAntibiotics = false;

    if(logisticRegressionScore < 0.6 || lassoRegressionScore < 0.625 || decisionTreeScore < 0.5)
      prescribeAntibiotics = true;

    if(logisticRegressionScore < 0.6)
      logisticGiveAntibiotics = true;

    if(lassoRegressionScore < 0.625)
      lassoGiveAntibiotics = true;

    if(decisionTreeScore < 0.675)
      decisionGiveAntibiotics = true;

    return [logisticGiveAntibiotics, lassoGiveAntibiotics, decisionGiveAntibiotics, prescribeAntibiotics, logisticRegressionScore,
      lassoRegressionScore, decisionTreeScore];
  }
}