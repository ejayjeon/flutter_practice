import 'package:flutter/foundation.dart';
import 'package:sketch_pay/env/env.dart';
import 'package:sketch_pay/src/external/dio/dio_exception.dart';
import 'package:sketch_pay/src/external/dio/dio_interceptor.dart';
import 'package:sketch_pay/src/external/storage/storage_service.dart';
import 'package:sketch_pay/src/shared/mixins/exception_handler_mixin.dart';
import 'package:sketch_pay/src/shared/models/either.dart';
import 'package:sketch_pay/src/shared/models/model.dart';
import 'package:dio/dio.dart' hide DioException;
import 'package:sketch_pay/src/shared/types/typedef.dart';
import 'package:sketch_pay/src/shared/utils/api_util.dart';

abstract class IDioService {
  String get baseUrl;

  JSON get headers;

  BaseOptions get baseOptions;

  Future<Either<DioException, ApiResponse<T>>> get<T>(
    String path, {
    JSON? queryParameters,
    Options? options,
    T Function(Object?)? mapper,
  });

  Future<Either<DioException, ApiResponse<T>>> post<T>(
    String path, {
    JSON? queryParameters,
    JSON? data,
    Options? options,
    T Function(Object?)? mapper,
  });

  Future<Either<DioException, ApiResponse<T>>> patch<T>(
    String path, {
    JSON? queryParameters,
    JSON? data,
    Options? options,
    T Function(Object?)? mapper,
  });

  Future<Either<DioException, ApiResponse<T>>> delete<T>(
    String path, {
    JSON? queryParameters,
    JSON? data,
    Options? options,
    T Function(Object?)? mapper,
  });
}

class DioService extends IDioService with ExceptionHandlerMixin {
  final Dio dio;
  final StorageService storage;
  DioService(this.dio, this.storage) {
    dio.options = baseOptions;
    if (kDebugMode) {
      dio.interceptors.add(DioInterceptor(dio, storage));
    }
  }
  @override
  BaseOptions get baseOptions => BaseOptions(
        baseUrl: baseUrl,
        headers: headers,
      );

  @override
  String get baseUrl => Env.vapgUrl;

  @override
  JSON get headers => {
        'accept': '*/*',
        'content-type': 'application/json; charset=utf-8',
      };

  @override
  Future<Either<DioException, ApiResponse<T>>> get<T>(
    String path, {
    JSON? queryParameters,
    Options? options,
    T Function(Object?)? mapper,
  }) async {
    final res = await handleException(
      () => dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      ),
      path: path,
    );
    return res.fold(
      (left) => Either.left(left),
      (right) => Either.right(
        ApiResponse<T>(
          meta: right.meta,
          auth: right.auth,
          data: mapper != null ? mapper(right.data) : right.data as T,
        ),
      ),
    );
  }

  @override
  Future<Either<DioException, ApiResponse<T>>> post<T>(
    String path, {
    JSON? queryParameters,
    JSON? data,
    Options? options,
    T Function(Object? p1)? mapper,
  }) async {
    final res = await handleException(
      () => dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
      path: path,
    );
    return res.fold(
      (left) => Either.left(left),
      (right) => Either.right(
        ApiResponse<T>(
          meta: right.meta,
          auth: right.auth,
          data: mapper != null ? mapper(right.data) : right.data as T,
        ),
      ),
    );
  }

  @override
  Future<Either<DioException, ApiResponse<T>>> patch<T>(
    String path, {
    JSON? queryParameters,
    JSON? data,
    Options? options,
    T Function(Object? p1)? mapper,
  }) async {
    final res = await handleException(
      () => dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
      path: path,
    );
    return res.fold(
      (left) => Either.left(left),
      (right) => Either.right(
        ApiResponse<T>(
          meta: right.meta,
          auth: right.auth,
          data: mapper != null ? mapper(right.data) : right.data as T,
        ),
      ),
    );
  }

  @override
  Future<Either<DioException, ApiResponse<T>>> delete<T>(
    String path, {
    JSON? queryParameters,
    JSON? data,
    Options? options,
    T Function(Object? p1)? mapper,
  }) async {
    final res = await handleException(
      () => dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
      path: path,
    );
    return res.fold(
      (left) => Either.left(left),
      (right) => Either.right(
        ApiResponse<T>(
          meta: right.meta,
          auth: right.auth,
          data: mapper != null ? mapper(right.data) : right.data as T,
        ),
      ),
    );
  }
}
