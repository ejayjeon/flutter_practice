part of 'provider.dart';

final ipProvider = Provider((ref) async {
  // final dio = ref.watch(dioProvider).dio;

  // try {
  //   dio.options.baseUrl = '';
  //   var response = await dio.get(getIpHost);
  //   if (response.statusCode == 200) {
  //     return Future.value(response.data['ip']);
  //   }
  // } on DioException catch (e) {
  //   log(e.toString());
  // }
  final dio = Dio();

  try {
    dio.options.baseUrl = getIpHost;
    var response = await dio.get(getIpHost);
    if (response.statusCode == 200) {
      return Future.value(response.data['ip']);
    }
  } on DioException catch (e) {
    log(e.toString());
  }
});
