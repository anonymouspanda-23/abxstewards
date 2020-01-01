import 'dart:async';

class UpdateConnectionBLoC {
  static UpdateConnectionBLoC _updateConnectionBLoC = UpdateConnectionBLoC._internal();
  factory UpdateConnectionBLoC() => _updateConnectionBLoC;
  UpdateConnectionBLoC._internal();

  StreamController _controller = StreamController.broadcast();
  Sink get updateConnectionSink => _controller.sink;
  Stream get updateConnectionStream => _controller.stream.asBroadcastStream();

  dispose() {
    _controller.close();
  }
}