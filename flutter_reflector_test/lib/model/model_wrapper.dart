import 'package:extension_methods_test/mixin/json_extension.dart';

class ModelWrapper<T> {
  final List<T> models;
  int? limit;
  int? skip;
  int? total;

  ModelWrapper({
    required this.models,
    this.limit,
    this.skip,
    this.total,
  });

  JSON toJson() {
    JSON data = <String, dynamic>{};
    data = {
      'models': models.map((model) => model),
      'limit': limit,
      'skip': skip,
      'total': total,
    };
    return data;
  }
}
