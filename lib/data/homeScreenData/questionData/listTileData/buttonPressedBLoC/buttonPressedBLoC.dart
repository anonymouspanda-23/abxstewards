import 'dart:async';

class ButtonPressedBLoC {
  static ButtonPressedBLoC _buttonPressedBLoC = ButtonPressedBLoC._internal();
  factory ButtonPressedBLoC() {
    return _buttonPressedBLoC;
  }
  ButtonPressedBLoC._internal();

  StreamController _rebuildListViewController = new StreamController.broadcast();
  Sink get buttonPressedSink => _rebuildListViewController.sink;
  Stream get rebuildListViewStream => _rebuildListViewController.stream;

  dispose() {
    _rebuildListViewController.close();
  }
}