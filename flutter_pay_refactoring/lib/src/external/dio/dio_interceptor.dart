import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:sketch_pay/src/external/storage/storage_service.dart';
import 'package:sketch_pay/src/shared/types/token_type.dart';

class DioInterceptor extends Interceptor {
  final Dio dio;
  final StorageService storage;
  late String message;

  DioInterceptor(this.dio, this.storage);

  @override
  String toString() => message;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // if (options.headers[TokenType.accessToken.title] == "true") {
    //   /// 1. 헤더 삭제
    //   options.headers.remove(TokenType.accessToken.title);

    //   /// 2. 기기에 저장된 AccessToken 로드
    //   final accessToken = await storage.get(TokenType.accessToken.key);

    //   /// 3. 요청 헤더가 AccessToken 로드 -> 포함
    //   options.headers['Authorization'] = "Bearer $accessToken";
    // }

    // if (options.headers[TokenType.refreshToken.title] == "true") {
    //   options.headers.remove(TokenType.refreshToken.title);
    //   final refreshToken = await storage.get(TokenType.refreshToken.key);
    //   options.headers['Authorization'] = "Bearer $refreshToken";
    // }

    log('${options.uri} 요청중...', name: options.method);
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        message = 'connectionTimeout';
        break;
      case DioExceptionType.sendTimeout:
        message = 'sendTimeout';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'receiveTimeout';
        break;
      case DioExceptionType.badCertificate:
        message = 'badCertificate';
        break;
      case DioExceptionType.badResponse:
        message = 'badResponse';
        break;
      case DioExceptionType.cancel:
        message = 'cancel';
        break;
      case DioExceptionType.connectionError:
        message = 'connectionError';
        break;
      case DioExceptionType.unknown:
        message = 'unknown';
        break;
    }

    // /// 1. RefreshToken 불러온다
    // final refreshToken = await storage.get(TokenType.refreshToken.key);

    // /// [RefreshToken이 없다면 에러를 던진다]
    // if (refreshToken == null) {
    //   return handler.reject(err);
    // }

    // /// [인증오류]
    // if (err.response?.statusCode == 401) {
    //   /// 1. 토큰 갱신
    //   try {
    //     final Response<dynamic> response = await dio.post(
    //       "/api/v1/admin/createToken",
    //       options: Options(
    //         headers: {
    //           "authorization": "Bearer $refreshToken",
    //         },
    //       ),
    //     );

    //     /// 2. Storage에 토큰 저장
    //     final accessToken = response.data[TokenType.accessToken.title];
    //     if (response.data != null) {
    //       await storage.remove(TokenType.accessToken.key);
    //       await storage.remove(TokenType.refreshToken.key);

    //       await storage.set(TokenType.accessToken.key,
    //           response.data[TokenType.accessToken.title]);
    //       await storage.set(TokenType.refreshToken.key,
    //           response.data[TokenType.refreshToken.title]);
    //     }

    //     /// 3. 헤더의 토큰 변경
    //     err.requestOptions.headers.addAll({
    //       "authorization": "Bearer $accessToken",
    //     });

    //     /// 4. 요청 재전송
    //     final requestRepeat = await dio.request(
    //       err.requestOptions.path,
    //       options: Options(
    //         method: err.requestOptions.method,
    //         headers: err.requestOptions.headers,
    //       ),
    //       data: err.requestOptions.data,
    //       queryParameters: err.requestOptions.queryParameters,
    //     );

    //     return handler.resolve(requestRepeat);
    //   } on DioException catch (e) {
    //     log(e.toString(), name: "DioException");
    //     return handler.reject(err);
    //   }
    // }

    return handler.next(err);
  }
}
