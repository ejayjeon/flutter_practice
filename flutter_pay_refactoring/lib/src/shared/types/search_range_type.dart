enum SearchRangeType {
  today(korName: "오늘", engName: "Today", days: 1),
  oneWeek(korName: "7일", engName: "7-days", days: 7),
  oneMonth(korName: "1개월", engName: "1 Month", days: 30),
  threeMonths(korName: "3개월", engName: "3 Months", days: 90),
  sixMonths(korName: "6개월", engName: "6 Months", days: 180);

  final String korName;
  final String engName;
  final int days;

  const SearchRangeType({
    required this.korName,
    required this.engName,
    required this.days,
  });

  static int getDays(String name) {
    for (SearchRangeType type in SearchRangeType.values) {
      if (type.korName == name || type.engName == name) {
        return type.days;
      }
    }
    throw Exception("Invalid name: $name");
  }
}
