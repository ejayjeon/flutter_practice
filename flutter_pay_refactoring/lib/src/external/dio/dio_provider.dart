import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sketch_pay/src/external/dio/dio_service.dart';
import 'package:sketch_pay/src/external/storage/storage_provider.dart';

final dioProvider = Provider<DioService>((ref) {
  final Dio dio = Dio();
  final storage = ref.watch(storageProvider);

  return DioService(dio, storage);
});
