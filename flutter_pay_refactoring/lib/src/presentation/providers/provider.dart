import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sketch_pay/src/data/models/model.dart';
import 'package:sketch_pay/src/domain/providers/provider.dart';
import 'package:sketch_pay/src/domain/repositories/repository.dart';
import 'package:sketch_pay/src/external/dio/dio_exception.dart';
import 'package:sketch_pay/src/presentation/providers/auth/reset_pin/timer_notifier.dart';
import 'package:sketch_pay/src/shared/extensions/datetime_extension.dart';
import 'package:sketch_pay/src/shared/types/search_range_type.dart';
import 'package:sketch_pay/src/shared/types/typedef.dart';

part 'provider.g.dart';
part 'provider.freezed.dart';

part 'setting/setting_notifier.dart';
part 'setting/state/setting_language_state.dart';
part 'main/home/home_point_state.dart';
part 'main/home/home_point_notifier.dart';

part 'main/history/history_state.dart';
part 'main/history/history_notifer.dart';
part 'main/history/history_provider.dart';

part 'main/payment/payment_notifier.dart';
part 'main/payment/payment_provider.dart';
part 'main/payment/payment_state.dart';

part 'auth/reset_pin/reset_pin_state.dart';
part 'auth/reset_pin/reset_pin_notifier.dart';
part 'auth/reset_pin/reset_pin_provider.dart';
