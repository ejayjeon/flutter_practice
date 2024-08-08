///////////////////////////
/// 이미지에서 객체를 인식하고
/// 객체에 대한 정보를 반환
//////////////////////////
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as imageLib;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper_plus/tflite_flutter_helper_plus.dart';
import 'package:tflite_test/models/recognition.dart';

// 1. 이미 학습된 객체 인식 모델을 로드
// 2. 이미지를 입력해서 사용
// 3. 객체 인식을 수행
// 4. 인식된 객체에 대한 정보 반환
class Classifire {
  Interpreter? _interpreter;
  List<String>? _labels;
  ImageProcessor? imageProcessor;
  int? padSize;
  List<List<int>>? _outputShapes;
  // List<TfLiteType>? _outputTypes;
  List<TensorType>? _outputTypes;

  // 외부에서 받아온 값
  Classifire({
    Interpreter? interpreter,
    List<String>? labels,
  }) {
    loadModel(interpreter: interpreter);
    loadLabel(labels: labels);
  }

  // 인터프리터 및 레이블 getter
  Interpreter? get interpreter => _interpreter;
  List<String>? get labels => _labels;

  static const String MODEL_FILE_NAME = 'detect.tflite';
  static const String LABEL_FILE_NAME = 'labelmap.txt';
  static const int INPUT_SIZE = 300; // 입력 크기
  static const double THRESHOLD = 0.5; // 임계값
  static const int NUM_RESULTS = 30;

  // 머신러닝 모델 로드
  void loadModel({Interpreter? interpreter}) async {
    try {
      // interpreter: 모델을 통해 추론한 것을 읽어들임
      _interpreter = interpreter ??
          await Interpreter.fromAsset(
            'assets/$MODEL_FILE_NAME',
            options: InterpreterOptions()..threads = 4,
          );
      var outputTensors = _interpreter?.getOutputTensors();
      _outputShapes = [];
      _outputTypes = [];
      outputTensors?.forEach((tensor) {
        _outputShapes?.add(tensor.shape);
        _outputTypes?.add(tensor.type);
      });
    } catch (e) {
      print(e);
    }
  }

  // 이미지의 레이블 로드
  void loadLabel({List<String>? labels}) async {
    try {
      _labels = labels ?? await FileUtil.loadLabels('assets/$LABEL_FILE_NAME');
    } catch (e) {
      print(e);
    }
  }

  // 입력한 이미지를 사이즈에 맞게 처리해서 빌드
  TensorImage getProcessedImage(TensorImage? inputImage) {
    padSize = max(inputImage?.height ?? 0, inputImage?.width ?? 0);

    imageProcessor ??= ImageProcessorBuilder()
        .add(ResizeWithCropOrPadOp(padSize ?? 0, padSize ?? 0))
        .add(ResizeOp(INPUT_SIZE, INPUT_SIZE, ResizeMethod.bilinear))
        .build();
    inputImage = imageProcessor?.process(inputImage!);
    return inputImage!;
  }

  // 이미지를 예측하고 인식 결과를 반환
  Map<String, dynamic>? predict(imageLib.Image image) {
    if (_interpreter == null) {
      return null;
    }

    // 입력된 이미지를 처리하고 예측
    TensorImage inputImage = TensorImage.fromImage(image);
    inputImage = getProcessedImage(inputImage);

    // 각 출력 텐서를 저장할 TensorBuffer
    TensorBuffer outputLocations = TensorBufferFloat(_outputShapes![0]);
    TensorBuffer outputClasses = TensorBufferFloat(_outputShapes![1]);
    TensorBuffer outputScores = TensorBufferFloat(_outputShapes![2]);
    TensorBuffer numLocations = TensorBufferFloat(_outputShapes![3]);

    // 입력된 이미지들
    List<Object> inputs = [inputImage.buffer];

    // 출력에 해당하는 TensorBuffer를 저장할 Map
    Map<int, Object> outputs = {
      0: outputLocations.buffer,
      1: outputClasses.buffer,
      2: outputScores.buffer,
      3: numLocations.buffer,
    };

    // 머신러닝 모델 Run
    _interpreter?.runForMultipleInputs(inputs, outputs);
    int resultsCount = min(NUM_RESULTS, numLocations.getIntValue(0));
    int labelOffset = 1;

    // 인식된 객체의 위치 반환
    List<Rect> locations = BoundingBoxUtils.convert(
      tensor: outputLocations,
      boundingBoxAxis: 2,
      boundingBoxType: BoundingBoxType.boundaries,
      coordinateType: CoordinateType.ratio,
      height: INPUT_SIZE,
      width: INPUT_SIZE,
    );

    // 인식 결과를 저장할 목록 정의
    List<Recognition> recognitions = [];

    // 각 인식 결과를 Recognition 객체로 생성하고 목록에 추가
    for (int i = 0; i < resultsCount; i++) {
      var score = outputScores.getDoubleValue(i);
      var labelIndex = outputClasses.getIntValue(i) + labelOffset;
      var label = _labels?.elementAt(labelIndex);

      if (score > THRESHOLD) {
        Rect? transformedRect = imageProcessor?.inverseTransformRect(
          locations[i],
          image.height,
          image.width,
        );

        recognitions.add(
          Recognition(i, label, score, transformedRect),
        );
      }
    }

    return {
      'recognitions': recognitions,
    };
  }
}
