import 'dart:isolate';

import 'package:camera/camera.dart';
import 'package:image/image.dart' as imageLib;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_test/models/classifier.dart';
import 'package:tflite_test/utils/image_utils.dart';

// Isolate를 사용해서 여러 개의 독립적인 실행 스레드에서 동시에 이미지 추론을 처리하게 함

class IsolateUtils {
  Isolate? _isolate;
  final ReceivePort _receivePort = ReceivePort(); // 자기 자신의 receivePort
  SendPort? _sendPort;
  SendPort? get sendPort => _sendPort;

  // Isolate 시작
  Future<void> start() async {
    _isolate = await Isolate.spawn<SendPort>(entryPoint, _receivePort.sendPort);
    _sendPort = await _receivePort.first;
  }

  // Isolate의 EntryPoint 함수: top-level function
  static void entryPoint(SendPort sendPort) async {
    final port = ReceivePort();
    sendPort.send(port.sendPort);

    await for (final IsolateData isolateData in port) {
      Classifire classifire = Classifire(
        interpreter: Interpreter.fromAddress(isolateData.interpreterAddress),
        labels: isolateData.labels,
      );
      imageLib.Image? image =
          ImageUtils.convertCameraImage(isolateData.cameraImage);
      image = imageLib.copyRotate(image!, 90);
      Map<String, dynamic>? results = classifire.predict(image);
      isolateData.responsePort?.send(results);
    }
  }
}

// Isolate 간에 전달할 데이터 클래스
class IsolateData {
  CameraImage cameraImage;
  int interpreterAddress;
  List<String> labels;
  SendPort? responsePort;

  IsolateData(this.cameraImage, this.interpreterAddress, this.labels);
}
