import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide DioException;
import 'package:sketch_pay/env/env.dart';
import 'package:sketch_pay/src/data/models/model.dart';
import 'package:sketch_pay/src/external/dio/dio_exception.dart';
import 'package:sketch_pay/src/external/dio/dio_provider.dart';
import 'package:sketch_pay/src/external/dio/dio_service.dart';
import 'package:sketch_pay/src/shared/models/either.dart';
import 'package:sketch_pay/src/shared/models/model.dart';
import 'package:sketch_pay/src/shared/types/typedef.dart';
import 'package:sketch_pay/src/shared/utils/api_util.dart';
part 'api_source.g.dart';

part 'history/history_api_service.dart';
part 'history/history_api.dart';
