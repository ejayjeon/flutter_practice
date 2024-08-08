import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sketch_pay/src/external/storage/storage_service.dart';

final storageProvider = Provider<StorageService>((ref) {
  final StorageServiceImpl _storageService = StorageServiceImpl();
  _storageService.init();
  return _storageService;
});
