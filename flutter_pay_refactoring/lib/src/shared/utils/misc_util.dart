import 'dart:math' hide log;

import 'package:intl/intl.dart';
import 'package:sketch_pay/src/shared/types/typedef.dart';

class MiscUtil {
  MiscUtil._();

  /// [For Search Condition]
  static List<String> cutOffDateFromString(dynamic date) {
    // var list = List<String>.empty();
    final dates = date.toString().split(' - '); // '-' 하면 2024-05-18 의 -로 나뉨
    // dates.map(
    //   (date) => list.add(
    //     DateTime.parse(date),
    //   ),
    // );
    return dates;
  }

  static rdInt({
    required int min,
    required int max,
  }) {
    final _random = Random();
    return min + _random.nextInt(max - min);
  }

  static getEv(String value) {
    String evConfig = const String.fromEnvironment("EV");
    final JSON configMap = stringToJsonMap(evConfig);
    return configMap[value];
  }

  static Map<String, dynamic> stringToJsonMap(String jsonStr) {
    Map<String, dynamic> resultMap = {};

    List<String> keyValuePairs = jsonStr.split(', ');

    for (var pair in keyValuePairs) {
      List<String> keyValue = pair.split(': ');

      if (keyValue.length == 2) {
        String key = keyValue[0];
        String value = keyValue[1];

        if (key.startsWith('{')) {
          key = key.substring(1);
        }
        if (key.endsWith('}')) {
          key = key.substring(0, key.length - 1);
        }

        if (value.startsWith('{')) {
          value = value.substring(1);
        }
        if (value.endsWith('}')) {
          value = value.substring(0, value.length - 1);
        }
        resultMap[key.trim()] = value.trim();
      } else {
        // LOG('Invalid pair: $pair');
      }
    }

    return resultMap;
  }

  static String switchCurrencyByCoinType(String coinType) {
    if (coinType == '00') {
      return 'KRW';
    } else if (coinType == '10') {
      return 'USD';
    } else {
      // 00, 10, 20
      return 'SKETCH';
    }
  }

  /// 8.231328... 이렇게 소수점으로 되어서 들어오는 부분 [8, 231328] 이렇게 분리
  static List<String> splitBalance(String balance) {
    List<String> listValue = balance.split('.');

    if (listValue.length == 1) {
      return [listValue[0], '0'];
    } else {
      String fractionalPart = listValue[1];
      if (fractionalPart.length > 6) {
        fractionalPart = '${fractionalPart.substring(0, 6)}...';
      }
      return [listValue[0], fractionalPart];
    }
  }

  static String currencyFormatter(String currency) {
    final formatter = NumberFormat('#,##0');
    return formatter.format(int.tryParse(currency) ?? 0);
  }

  /// [Null이 아닌 값을 찾아서 리턴해주는 함수]
  static JSON filterNonNullValues(JSON data) {
    return data..removeWhere((key, value) => value == null);
  }
}
