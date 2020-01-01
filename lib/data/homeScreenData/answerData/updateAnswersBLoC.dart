import 'dart:async';

class UpdateAnswersBLoC {
  static UpdateAnswersBLoC _updateAnswersBLoC = UpdateAnswersBLoC._internal();
  factory UpdateAnswersBLoC() => _updateAnswersBLoC;
  UpdateAnswersBLoC._internal();

  StreamController _controller = StreamController.broadcast();
  Sink get updateAnswersSink => _controller.sink;
  Stream get updateAnswersStream => _controller.stream.asBroadcastStream();

  dispose() {
    _controller.close();
  }
}