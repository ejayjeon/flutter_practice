import 'package:intl/intl.dart';

extension DatetimeExtension on DateTime {
  /// 1. [24/03/28]
  String get yyMMdd => DateFormat("yy/MM/dd").format(this);

  /// 2. [24/03/28 23:01:33]
  String get yyMMddHHmmss => DateFormat("yy/MM/dd HH:mm:ss").format(this);

  /// 3. [Mar 28, 2024]
  String get yMMMd => DateFormat("yMMMd").format(this);

  /// 4. [2024. 03. 28(목) 10:17]
  String get yyyyMMddE => DateFormat("yyyy.MM.dd(E) HH:mm").format(this);

  /// 5. [09:10]
  String get hhmm => DateFormat("HH:mm").format(this);

  /// 6. [2024-03-28]
  String get yy_MM_dd => DateFormat("yyyy-MM-dd").format(this);

  /// 7. [2024-03-28 24:00:00]
  String get yyyy_MM_dd => DateFormat("yyyy-MM-dd HH:mm:ss").format(this);
}
