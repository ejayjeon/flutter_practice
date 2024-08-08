import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' hide DioException;
import 'package:sketch_pay/src/external/dio/dio_exception.dart';
// import 'package:dio/dio.dart';
import 'package:sketch_pay/src/external/dio/dio_service.dart';
import 'package:sketch_pay/src/shared/models/either.dart';
import 'package:sketch_pay/src/shared/models/model.dart';
import 'package:sketch_pay/src/shared/utils/api_util.dart';

mixin ExceptionHandlerMixin<T> on IDioService {
  Future<Either<DioException, ApiResponse<T>>> handleException(
    Future<Response<dynamic>> Function() handler, {
    String path = "",
  }) async {
    // try {
    final res = await handler();
    if (res.data['params'] != null) {
      final result = ApiUtil.responseDecodingFromParams(data: res.data);
      return Right(
        ApiResponse(
          meta: ApiMetaModel.fromJson(result['meta']),
          auth: ApiAuthModel.fromJson(result['auth']),
          data: result['params'],
        ),
      );
    } else {
      return Left(
        DioException(
          message: res.data['msg'],
          statusCode: int.parse(res.data['code']),
          identifier: '',
        ),
      );
    }

    // } catch (e) {
    //   String message = "";
    //   String identifier = "";
    //   int statusCode = 0;
    //   log(e.toString(), name: "ExceptionHandlerMixin");
    //   switch (e.runtimeType) {
    //     case SocketException _:
    //       e as SocketException;
    //       message = "Unable to connect to Socket server";
    //       statusCode = -1;
    //       identifier = "$e: ${e.message}";
    //       break;
    //     case DioException _:
    //       e as DioException;
    //       message = "Unable to connect to Http server";
    //       statusCode = -1;
    //       identifier = "$e: ${e.message}";
    //       break;
    //     default:
    //       message = "Unknown Error Occurred";
    //       statusCode = -1;
    //       identifier = "Unknown Error ${e.toString()} \n at $path";
    //   }
    //   // return Left(
    //   //   DioException(
    //   //     message: message,
    //   //     statusCode: statusCode,
    //   //     identifier: identifier,
    //   //   ),
    //   // );
    // }
  }
}
