part of '../../provider.dart';

class HistoryNotifier extends StateNotifier<HistoryState> {
  final HistoryRepository repository;
  HistoryNotifier(
    this.repository,
  ) : super(const HistoryState.initial()) {
    fetchData();
  }

  /// [JSON data를 만들기 위한 변수]

  String selectedCode = "";
  DateTime fromDt = DateTime.now().subtract(const Duration(days: 7));
  DateTime toDt = DateTime.now();
  int selectedOrderIndex = 0;
  int selectedRangeIndex = 0;
  int selectedCategoryIndex = 0;

  /// [데이터]
  List<TypeList> categoryList = List<TypeList>.from([]);
  List<ParamList> dataList = List<ParamList>.from([]);
  Map<String, List<ParamList>> groupedData = {};
  Map<String, List<ParamList>> paymentGroupedData = {};
  List<ParamList>? filteredData;

  /// [페이지네이션]
  int _currentPage = 1;
  int pageSize = 10;
  int maxSize = 0;

  /// [최초에 History를 가져오는 로직]
  Future _serverFetchData({int count = 0}) async {
    state = const HistoryState.loading();
    JSON data = {};

    data['acctCd'] = "ABCD123";
    data['fromDt'] = fromDt.yyyy_MM_dd;
    data['toDt'] = toDt.yyyy_MM_dd;
    data['pageSize'] = pageSize.toString();
    data['currentPage'] = (_currentPage += count).toString(); // 현재 데이터의 길이
    data['category'] = selectedCode;

    final res = await repository.payHistory(data: data);
    var result;
    res.fold(
      (failure) {
        state = const HistoryState.failure();
        result = failure;
      },
      (success) {
        state = const HistoryState.success();
        result = success.data as PayHistoryModel;
      },
    );
    return result;
  }

  /// [데이터 리스트 만드는 로직]
  Future<void> fetchData() async {
    if (dataList.isNotEmpty) {
      dataList = List<ParamList>.from([]);
    }
    final data = await _serverFetchData();
    final isPayhistoryModel = data is PayHistoryModel;
    if (!isPayhistoryModel) {
      state = const HistoryState.empty();
      PayHistoryModel.empty();
    }

    final list = data.list;
    final typeList = data.typeList;
    maxSize = data.cnt;

    if (maxSize == 0) {
      state = const HistoryState.empty();
      return; // 리턴을 안하면, state가 empty가 되더라도 아래 _setDataList로 넘어가버림
    }

    _setDataList(list);
    _setTypeList(typeList);
    state = const HistoryState.success();
  }

  /// [데이터를 더 가져오는 로직]
  Future<void> fetchingMoreData() async {
    final oldList = List<ParamList>.from(dataList); // deep copy

    if (oldList.length < maxSize) {
      final data = await _serverFetchData(count: 1);
      data is PayHistoryModel;
      final isPayhistoryModel = data is PayHistoryModel;

      if (!isPayhistoryModel) {
        state = const HistoryState.failure();
        PayHistoryModel.empty();
      }

      final list = List<ParamList>.from(data.list);

      /// 기존에 데이터가 있는 경우,
      if (list.isNotEmpty) {
        _setDataList(list, oldList: oldList);
      } else {
        _setDataList(list);
      }

      log("maxSize: $maxSize / dataList: ${dataList.length}");
    }
  }

  /// [onRefresh용]
  Future<void> refreshData() async {
    _currentPage = 1;
    await fetchData();
  }

  /// [히스토리의 카테고리 가져오는 로직]
  Future<List<TypeList>> _setTypeList(List<TypeList> typeList) async {
    Set<TypeList> categorySet = Set.from({});
    categorySet = {...typeList};
    categoryList = List.from(categorySet);
    state = const HistoryState.success();
    return categoryList;
  }

  /// [히스토리 데이터 가져오는 로직]
  Future<void> _setDataList(
    List<ParamList> list, {
    List<ParamList>? oldList,
  }) async {
    Set<ParamList> dataSet = Set.from({});

    //
    if (oldList != null) {
      dataSet = {...oldList, ...list};
    } else {
      dataSet = {...list};
    }
    dataList = List.from(dataSet);

    _getDataList(dataList);
  }

  /// [카테고리 정제하는 로직]
  /// TODO: DioException일 때 예외 처리 필요
  List<String?> getCategoryNameList() {
    String localName = Platform.localeName;
    final isKor = localName == "ko_KR";
    final list = categoryList
        .map((item) => isKor ? item.codeNmKor : item.codeNmEng)
        .toList();
    list.insert(0, "전체");
    return list;
  }

  List<String?> getCategoryCodeList() {
    final list = categoryList.map((item) => item.detailCode).toList();
    list.insert(0, "");
    return list;
  }

  /// [가져온 데이터를 정제하는 로직]
  Future<Map<String, List<ParamList>>?> _getDataList(
      List<ParamList> dataList) async {
    // 카태고리 클릭, 해당 카테고리의 타입과 같거나 All('')인 경우 가져오기
    state = const HistoryState.loading();
    filteredData = dataList
        .where((data) => selectedCode == data.category || selectedCode == '')
        .toList();

    /// [날짜 순 그룹]
    groupedData = ParamList()
        .groupBy(filteredData!, (data) => data.crtDt.toString().split(' ')[0]);

    /// [결제 별 동일한 reqId 그룹]
    paymentGroupedData =
        ParamList().groupBy(filteredData!, (data) => data.reqId.toString());
    if (groupedData.isEmpty) {
      state = const HistoryState.empty();
    }
    state = const HistoryState.success();
    return groupedData;
  }

  /// [네트워크 이미지 아이콘 가져오는 로직]
  String? getIconPathFromCode({required String code}) {
    /// TODO: dataList.length는 현재 가지고 올 수 있는 데이터의 갯수오 ㅏ같음...
    if (dataList.length < maxSize || code.isNotEmpty) {
      var result =
          categoryList.firstWhere((category) => category.detailCode == code);

      return result.imageUrl;
    }
    return '';
  }

  /// [달력 정렬을 위한 버튼 클릭 메소드]
  onRangeDestinationSelected(int index, String title) {
    _onSubtractPeriod(SearchRangeType.getDays(title));
    selectedRangeIndex = index;
  }

  _onSubtractPeriod(int period) {
    fromDt = DateTime.now().subtract(Duration(days: period));
    toDt = DateTime.now();
  }

  /// [데이터 정렬을 위한 버튼 클릭 메소드]
  onOrderDestinationselected(int index) {
    selectedOrderIndex = index;

    /// 0: 최신순
    /// 1: 과거순
    if (dataList.isNotEmpty) {
      if (index == 0) {
        dataList.sort((a, b) => b.crtDt!.compareTo(a.crtDt!));
      } else {
        dataList.sort((a, b) => a.crtDt!.compareTo(b.crtDt!));
      }
    }
  }

  onDestinationSelectedWithTitle(int index, String title) {
    selectedCategoryIndex = index;
    selectedCode = title;
    refreshData();
  }

  onDownPressed() {
    if (pageSize > 1) {
      pageSize--;
    } else {
      // context.showToast(message: "${notifier.pageSize} 이하로 설정할 수 없습니다.");
    }
  }

  onUpPressed() {
    if (pageSize < 10) {
      pageSize++;
    } else {
      // context.showToast(message: "${notifier.pageSize} 이상으로 설정할 수 없습니다");
    }
  }
}
