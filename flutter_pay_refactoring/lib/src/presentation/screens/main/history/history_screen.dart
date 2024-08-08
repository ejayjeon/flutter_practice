import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sketch_pay/src/data/models/model.dart';
import 'package:sketch_pay/src/presentation/providers/provider.dart';
import 'package:sketch_pay/src/presentation/screens/main/history/widgets/search_condition_sheet.dart';
import 'package:sketch_pay/src/shared/extensions/context_extension.dart';
import 'package:sketch_pay/src/shared/extensions/datetime_extension.dart';
import 'package:sketch_pay/src/shared/extensions/widget_extension.dart';
import 'package:sketch_pay/src/shared/mixins/scroll_controller_mixin.dart';
import 'package:sketch_pay/src/shared/routes/router.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';
import 'package:sketch_pay/src/shared/types/typedef.dart';
import 'package:sketch_pay/src/shared/utils/image_util.dart';
import 'package:sketch_pay/src/shared/utils/path_util.dart';
import 'package:sketch_pay/src/shared/widgets/button/app_toggle_button.dart';
import 'package:sketch_pay/src/shared/widgets/misc/balance_coin_type_span.dart';
import 'package:sketch_pay/src/shared/widgets/misc/balance_text_span.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen>
    with ScrollControllerMixin, SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  onDownPressed() {
    final notifier = ref.read(historyProvider.notifier);
    if (notifier.pageSize > 1) {
      // setState(() {
      //   notifier.pageSize--;
      // });
      notifier.onDownPressed();
    } else {
      context.showToast(message: "${notifier.pageSize} 이하로 설정할 수 없습니다.");
    }
  }

  onUpPressed() {
    final notifier = ref.read(historyProvider.notifier);
    if (notifier.pageSize < 10) {
      // setState(() {
      //   notifier.pageSize++;
      // });
      notifier.onUpPressed();
    } else {
      context.showToast(message: "${notifier.pageSize} 이상으로 설정할 수 없습니다");
    }
  }

  scrollAnimation({
    required ScrollController controller,
    required double offset,
  }) {
    return controller.animateTo(
      offset,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  JSON dataPerState(String state) {
    JSON data = {};
    switch (state) {
      case '10':
        data['color'] = Colors.yellow;
        data['label'] = "진행중";
        break;
      case '30':
        data['color'] = AppColor.red;
        data['label'] = "실패";
        break;
      case '90':
        data['color'] = AppColor.primary;
        data['label'] = "성공";
        break;
      case '09':
        data['color'] = AppColor.red;
        data['label'] = "취소";
      default:
        data['color'] = AppColor.bgGrey;
        data['label'] = "-";
        break;
    }
    return data;
  }

  @override
  void scrollListener() {
    super.scrollListener();
    final notifier = ref.watch(historyProvider.notifier);
    var position = scrollController.position.pixels >
        scrollController.position.maxScrollExtent;

    scrollDebouncer(() async {
      if (position && scrollController.hasClients) {
        setState(() {
          position = !position; // 추가로 API
        });
        await notifier.fetchingMoreData();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (scrollController.hasClients) {
            scrollController.jumpTo(scrollPosition);
          }
        });
      }
    });
  }

  @override
  void secondScrollListener() {
    setState(() {
      toLeft = secondScrollController.position.pixels >
          secondScrollController.position.maxScrollExtent / 2;
      toRight = secondScrollController.position.pixels <
          secondScrollController.position.maxScrollExtent - 110;
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: -30).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(historyProvider);
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Consumer(
              builder: (context, ref, _) {
                final notifier = ref.watch(historyProvider.notifier);
                return _headerCategoryButtons(
                  context,
                  selectedIndex: notifier.selectedCategoryIndex,
                  buttonTitles: notifier.getCategoryNameList(),
                  buttonCodes: notifier.getCategoryCodeList(),
                  onDestinationSelectedWithTitle:
                      notifier.onDestinationSelectedWithTitle,
                  controller: secondScrollController,
                  onLeftPressed: () => scrollAnimation(
                      controller: secondScrollController, offset: 0.0),
                  onRightPressed: () => scrollAnimation(
                    controller: secondScrollController,
                    offset: secondScrollController.position.maxScrollExtent,
                  ),
                ).paddingSymmetric(size: const Size(12, 8));
              },
            ),
            Consumer(
              builder: (context, ref, _) {
                final notifier = ref.watch(historyProvider.notifier);
                return Expanded(
                  child: Stack(
                    children: [
                      state.when(
                        initial: () =>
                            _showEmptyWidget(context, title: "최초 화면"),
                        // loading: () => const CircularProgressIndicator(
                        //   color: AppColor.primary,
                        // ).center,
                        loading: () {
                          return notifier.dataList.isNotEmpty
                              ? _historyList(
                                  context,
                                  controller: scrollController,
                                  notifier: notifier,
                                )
                              : const CircularProgressIndicator(
                                  color: AppColor.primary,
                                ).center;
                        },
                        failure: () =>
                            _showEmptyWidget(context, title: "에러 발생"),
                        empty: () =>
                            _showEmptyWidget(context, title: "목록이 비어있다"),
                        success: () => _historyList(
                          context,
                          controller: scrollController,
                          notifier: notifier,
                        ),
                      ),
                      if (state == const HistoryState.loading()) ...[
                        Positioned.fill(
                          child: Stack(
                            children: <Widget>[
                              Opacity(
                                opacity: 0.5,
                                child: ModalBarrier(
                                  dismissible: false,
                                  color: Colors.black.withOpacity(0.8),
                                ),
                              ),
                              const Center(
                                child: CircularProgressIndicator(
                                  color: AppColor.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        Consumer(
          builder: (context, ref, _) {
            final notifier = ref.watch(historyProvider.notifier);
            return _fabForSettingCondition(
              onPressed: () => context.showBottomSheet(
                child: SearchConditionSheet(
                  rangeOfPeriodList: const ["오늘", "7일", "1개월", "3개월", "6개월"],
                  rangeOfOrderList: const ["최신순", "과거순"],
                  selectRangeIndex: notifier.selectedRangeIndex,
                  onRangeDestinationSelected:
                      notifier.onRangeDestinationSelected,
                  selectedOrderIndex: notifier.selectedOrderIndex,
                  onOrderDestinationselected:
                      notifier.onOrderDestinationselected,
                  currentPageCount: notifier.pageSize,
                  onDownPressed: notifier.onDownPressed,
                  onUpPressed: notifier.onUpPressed,
                  onSearchPressed: () {
                    context.pop();
                    notifier.refreshData();
                  },
                ),
              ),
            );
          },
        )
      ],
    ).paddingSymmetric(size: const Size(0, 8));
  }

  Widget _headerCategoryButtons(
    BuildContext context, {
    ScrollController? controller,
    required int selectedIndex,
    List<dynamic>? buttonTitles,
    List<dynamic>? buttonCodes,
    void Function(int, String)? onDestinationSelectedWithTitle,
    VoidCallback? onLeftPressed,
    onRightPressed,
  }) {
    return Stack(
      children: [
        SingleChildScrollView(
          controller: controller,
          scrollDirection: Axis.horizontal,
          child: AppToggleButton(
            buttonTitles: buttonTitles ?? [],
            buttonCodes: buttonCodes,
            selectedIndex: selectedIndex,
            onDestinationSelectedWithTitle: onDestinationSelectedWithTitle,
          ),
        ),
        if (toLeft) ...[
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: _arrowButtonToMove(
              context,
              icon: Icons.arrow_back_ios_new,
              onTap: onLeftPressed,
            ),
          ),
        ],
        if (toRight) ...[
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: _arrowButtonToMove(
              context,
              icon: Icons.arrow_forward_ios,
              onTap: onRightPressed,
            ),
          ),
        ],
      ],
    );
  }

  Widget _fabForSettingCondition({
    VoidCallback? onPressed,
    bool hasData = true,
  }) {
    return hasData
        ? AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            child: Positioned(
              bottom: 16.h,
              right: 8,
              child: FloatingActionButton(
                backgroundColor: AppColor.black,
                splashColor: AppColor.black.withOpacity(0.2),
                onPressed: onPressed,
                child: ImageUtil.showImage(
                  iconFilePath(fileName: "ic_calendar.svg", subFolder: "main"),
                  // color: AppColor.black,
                ),
              ),
            ),
          )
        : const SizedBox();
  }

  Widget _arrowButtonToMove(
    BuildContext context, {
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.black.withOpacity(0.6),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 30,
        ).center,
      ),
    );
  }

  Widget _historyList(
    BuildContext context, {
    // required Widget child,
    ScrollController? controller,
    required HistoryNotifier notifier,
  }) {
    return RefreshIndicator(
      semanticsLabel: "히스토리 리스트 가져오기",
      onRefresh: () => notifier.refreshData(),
      backgroundColor: AppColor.black.withOpacity(0.6),
      color: AppColor.primary,
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      child: ListView.builder(
        physics:
            const AlwaysScrollableScrollPhysics(), // 영역이 채워지지 않아서 스크롤이 안되는 순간에도 스크롤이 가능하도록 만듦
        shrinkWrap: true,
        controller: controller,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemCount: 1,
        itemBuilder: (_, index) {
          // goToSnapshotPosition();
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // for (final entry in notifier.groupedData.entries) ...[
              //   _historyDateBarItem(context, entry),
              //   for (final item in entry.value) ...[
              //     if (item.category == notifier.selectedCode ||
              //         notifier.selectedCode == '') ...[
              //       _historyItem(
              //         context,
              //         data: item,
              //         notifier: notifier,
              //         onTap: () => context.go(
              //           HistoryDetailRoute.path,
              //           extra: item,
              //         ),
              //       ),
              //     ],
              //   ],
              // ],
              for (final entry in notifier.groupedData.entries) ...[
                _historyDateBarItem(context, entry),
                for (final paymentEntry
                    in notifier.paymentGroupedData.entries) ...[
                  if (paymentEntry.value.length > 1) ...[
                    _linkForHistoryItem(
                      context,
                      data: paymentEntry.value[0],
                      child: Column(
                        children: <Widget>[
                          for (var i = 0;
                              i < paymentEntry.value.length;
                              i++) ...[
                            if (paymentEntry.value[i].category ==
                                    notifier.selectedCode ||
                                notifier.selectedCode == '') ...[
                              _historyItem(
                                context,
                                data: paymentEntry.value[i],
                                notifier: notifier,
                                onTap: () => context.go(
                                  HistoryDetailRoute.path,
                                  extra: paymentEntry.value[i],
                                ),
                                isPaymentGroup: true,
                                isFirstData: paymentEntry.value[i] ==
                                    paymentEntry.value[0],
                              ),
                            ]
                          ]
                        ],
                      ),
                    ),
                  ] else ...[
                    for (final item in paymentEntry.value) ...[
                      if (item.category == notifier.selectedCode ||
                          notifier.selectedCode == '') ...[
                        _historyItem(
                          context,
                          data: item,
                          notifier: notifier,
                          onTap: () => context.go(
                            HistoryDetailRoute.path,
                            extra: item,
                          ),
                        ),
                      ],
                    ],
                  ],
                ],
              ],
              _fetchingMoreButton(
                context,
                animation: _animation,
                onPressed: () {
                  notifier.fetchingMoreData();
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _linkForHistoryItem(
    BuildContext context, {
    required Widget child,
    required ParamList data,
  }) {
    return Container(
      padding: context.gap(size: const Size(0, 4)),
      margin: context.gap(size: const Size(0, 8)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey.withOpacity(0.7)),
        color: Colors.grey.withOpacity(0.1),
      ),
      child: child,
    );
  }

  Widget _historyDateBarItem(
      BuildContext context, MapEntry<String, List<ParamList>> entry) {
    return LayoutBuilder(
      builder: (_, constraints) => Container(
        width: constraints.maxWidth,
        color: AppColor.black,
        alignment: Alignment.centerLeft,
        padding: context.gap(isSymmetric: true, size: const Size(12, 8)),
        child: Text(
          entry.key,
          style: context.bodyText
              ?.copyWith(color: AppColor.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _historyItem(
    BuildContext context, {
    required ParamList data,
    required HistoryNotifier notifier,
    VoidCallback? onTap,
    bool isPaymentGroup = false,
    bool isFirstData = false,
  }) {
    return InkWell(
      // GestureDetecture은 Card 범위만큼 클릭효과가 전달되지 않음
      onTap: onTap,
      child: SizedBox(
        width: context.width,
        height: 130, // 아이템 개체 한 개의 높이임
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (isPaymentGroup) ...[
              Row(
                children: <Widget>[
                  if (isFirstData) ...[
                    Text(
                      DateTime.parse(data.crtDt.toString()).hhmm,
                      style: context.bodyText?.copyWith(
                        color: AppColor.bgGrey,
                        fontSize: 12,
                      ),
                    ),
                    const Divider(
                      color: AppColor.white,
                    ).flex(flex: 1),
                    Text(
                      data.storeName.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: context.bodyText?.copyWith(
                        color: AppColor.white,
                      ),
                    ),
                  ] else ...[
                    const Divider(
                      color: AppColor.white,
                    ).flex(flex: 1),
                  ],
                ],
              ),
            ] else ...[
              Row(
                children: <Widget>[
                  Text(
                    DateTime.parse(data.crtDt.toString()).hhmm,
                    style: context.bodyText?.copyWith(
                      color: AppColor.bgGrey,
                      fontSize: 12,
                    ),
                  ),
                  const Divider(
                    color: AppColor.white,
                  ).flex(flex: 1),
                ],
              ),
            ],
            Expanded(
              child: Row(
                children: <Widget>[
                  /// [Icon / imageUrl] + [payType]
                  CircleAvatar(
                    backgroundColor: AppColor.black,
                    child: ImageUtil.showImage(
                      notifier.getIconPathFromCode(
                        code: data.category ?? "",
                      )!,
                    ),
                  ).paddingOnly(right: 8),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              if (data.state != null) ...[
                                Badge(
                                  label: Text(
                                    dataPerState(data.state ?? "00")['label'],
                                    style:
                                        const TextStyle(color: AppColor.black),
                                  ),
                                  backgroundColor:
                                      dataPerState(data.state ?? "00")['color'],
                                ).paddingOnly(right: 4, bottom: 4, top: 8),
                              ],
                              Expanded(
                                child: Text(
                                  data.categoryNm.toString(),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: context.titleText
                                      ?.copyWith(color: AppColor.white),
                                ).paddingOnly(right: 8),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              BalanceTextSpan(
                                balance: data.valueSketch!.toString(),
                                balanceTextColor: AppColor.white,
                              ),
                              BalanceCoinTypeSpan(
                                coinType: data.coinType ?? '20',
                                textColor: AppColor.white,
                                textSize: 12,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ).paddingSymmetric(size: const Size(0, 0)),
      ).paddingSymmetric(size: const Size(16, 0)),
    );
  }

  Widget _fetchingMoreButton(
    BuildContext context, {
    required Animation<double> animation,
    VoidCallback? onPressed,
  }) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, animation.value),
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(0.6),
            ),
            child: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColor.white,
              size: 50,
            ).center,
          ),
        ),
      ),
    );
  }

  Widget _showEmptyWidget(BuildContext context, {required String title}) {
    return Text(
      title,
      style: context.titleText?.copyWith(color: AppColor.white),
    ).center;
  }
}
