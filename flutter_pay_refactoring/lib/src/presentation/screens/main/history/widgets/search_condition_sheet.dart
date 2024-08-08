import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sketch_pay/src/presentation/providers/provider.dart';
import 'package:sketch_pay/src/presentation/screens/main/history/widgets/date_select_box.dart';
import 'package:sketch_pay/src/shared/extensions/context_extension.dart';
import 'package:sketch_pay/src/shared/extensions/widget_extension.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';
import 'package:sketch_pay/src/shared/utils/input_formatter_util.dart';
import 'package:sketch_pay/src/shared/utils/misc_util.dart';
import 'package:sketch_pay/src/shared/widgets/button/app_button.dart';
import 'package:sketch_pay/src/shared/widgets/button/app_toggle_button.dart';

class SearchConditionSheet extends ConsumerStatefulWidget {
  final List<String> rangeOfPeriodList, rangeOfOrderList;
  final int selectRangeIndex, selectedOrderIndex, currentPageCount;
  final Function(int)? onOrderDestinationselected;
  final Function(int, String)? onRangeDestinationSelected;
  final VoidCallback? onSearchPressed, onDownPressed, onUpPressed;
  const SearchConditionSheet({
    super.key,
    required this.rangeOfPeriodList,
    required this.rangeOfOrderList,
    required this.selectRangeIndex,
    required this.selectedOrderIndex,
    required this.currentPageCount,
    this.onRangeDestinationSelected,
    this.onOrderDestinationselected,
    this.onSearchPressed,
    this.onDownPressed,
    this.onUpPressed,
  });

  @override
  ConsumerState<SearchConditionSheet> createState() =>
      _SearchConditionSheetState();
}

class _SearchConditionSheetState extends ConsumerState<SearchConditionSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height / 2,
      // padding: context.gap(size: const Size(12, 12)),
      decoration: const BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: <Widget>[
          _topBar(context, title: "검색 설정"),
          Expanded(
            child: SingleChildScrollView(
              padding: context.gap(size: const Size(12, 12)),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                children: <Widget>[
                  _title(context, title: "검색 기간"),
                  _onSelectRangeButton(
                    context,
                    selectedIndex: widget.selectRangeIndex,
                    buttonTitles: widget.rangeOfPeriodList,
                    onDestinationSelectedWithTitle:
                        widget.onRangeDestinationSelected,
                  ),
                  Consumer(
                    builder: (context, ref, _) => _rangeOfCondition(
                      context,
                      ref: ref,
                    ),
                  ),
                  const Divider(
                    color: AppColor.borderColor,
                  ),
                  _title(context, title: "정렬 순서"),
                  _onSelectOrderButton(
                    context,
                    buttonTitles: widget.rangeOfOrderList,
                    selectedIndex: widget.selectedOrderIndex,
                    onDestinationSelected: widget.onOrderDestinationselected,
                  ),
                  const Divider(
                    color: AppColor.borderColor,
                  ),
                  _title(context, title: "수량 범위"),
                  _rangeOfCount(context),
                  const Divider(
                    color: AppColor.borderColor,
                  ),
                  _title(context, title: "페이지 갯수"),
                  _upDownCountOfPage(
                    context,
                    currentPageCount: widget.currentPageCount,
                    onDownPressed: widget.onDownPressed,
                    onUpPressed: widget.onUpPressed,
                    ref: ref,
                  ),
                ],
              ),
            ),
          ),

          /// [누르면 검색 버튼]
          AppButton(
            label: "검색",
            paddingSize: const Size(0, 0),
            needRadius: false,
            labelColor: AppColor.black,
            onPressed: widget.onSearchPressed,
          )
        ],
      ),
    );
  }

  Widget _topBar(
    BuildContext context, {
    required String title,
    // VoidCallback? onPre
  }) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: context.headerText?.copyWith(color: AppColor.black),
          ),
        ),
        IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.close),
        )
      ],
    );
  }

  Widget _title(
    BuildContext context, {
    required String title,
  }) {
    return Text(
      title,
      style: context.bodyText?.copyWith(
        color: AppColor.black,
        fontWeight: FontWeight.w500,
      ),
    ).paddingSymmetric(size: const Size(0, 12)).bottomLeft;
  }

  Widget _onSelectRangeButton(
    BuildContext context, {
    required List<String> buttonTitles,
    required int selectedIndex,
    Function(int)? onDestinationSelected,
    Function(int, String)? onDestinationSelectedWithTitle,
  }) {
    return SizedBox(
      height: 30,
      child: AppToggleButton(
        selectedIndex: selectedIndex,
        buttonTitles: buttonTitles,
        buttonCodes: buttonTitles,
        onDestinationSelected: onDestinationSelected,
        onDestinationSelectedWithTitle: onDestinationSelectedWithTitle,
      ),
    );
  }

  Widget _rangeOfCondition(
    BuildContext context, {
    required WidgetRef ref,
  }) {
    final notifier = ref.watch(historyProvider.notifier);
    return SizedBox(
      width: context.width,
      child: Row(
        children: <Widget>[
          Expanded(
            child: DateSelectBox(
              onChanged: (date) async => context
                  .showDatePicker(
                rangeFirstDate: notifier.fromDt,
                rangeEndDate: notifier.toDt,
              )
                  .then((value) {
                if (value != null) {
                  final dateList = MiscUtil.cutOffDateFromString(value);
                  setState(() {
                    notifier.fromDt = DateTime.parse(dateList[0]);
                    notifier.toDt =
                        DateTime.parse(dateList[dateList.length - 1]);
                  });
                }
              }),
              date: notifier.fromDt,
            ),
          ),
          const Text(" ~ ").paddingSymmetric(size: const Size(14, 0)),
          Expanded(
            child: DateSelectBox(
              onChanged: (date) async => await context
                  .showDatePicker(
                rangeFirstDate: notifier.fromDt,
                rangeEndDate: notifier.toDt,
              )
                  .then((value) {
                if (value != null) {
                  final dateList = MiscUtil.cutOffDateFromString(value);
                  setState(() {
                    notifier.fromDt = DateTime.parse(dateList[0]);
                    notifier.toDt =
                        DateTime.parse(dateList[dateList.length - 1]);
                  });
                }
              }),
              date: notifier.toDt,
            ),
          )
        ],
      ),
    ).paddingSymmetric(size: const Size(0, 14));
  }

  Widget _onSelectOrderButton(
    BuildContext context, {
    required List<String> buttonTitles,
    required int selectedIndex,
    Function(int)? onDestinationSelected,
  }) {
    return SizedBox(
      height: 40,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: AppToggleButton(
          needPadding: false,
          selectedIndex: selectedIndex,
          buttonTitles: buttonTitles,
          onDestinationSelected: onDestinationSelected,
          buttonWidth: context.width,
        ),
      ),
    ).paddingOnly(bottom: 14);
  }

  Widget _rangeOfCount(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Row(
        children: <Widget>[
          Expanded(
            child: _countTextField(context),
          ),
          const Text(" ~ ").paddingSymmetric(size: const Size(14, 0)),
          Expanded(
            child: _countTextField(context, hintText: "ex) 0"),
          ),
        ],
      ),
    ).paddingOnly(bottom: 14);
  }

  TextFormField _countTextField(
    BuildContext context, {
    TextEditingController? controller,
    String? hintText,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      autofocus: true,
      inputFormatters: [
        InputFormatterUtil(),
      ],
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }

  Widget _upDownCountOfPage(
    BuildContext context, {
    VoidCallback? onDownPressed,
    VoidCallback? onUpPressed,
    required int currentPageCount,
    required WidgetRef ref,
  }) {
    final state = ref.watch(historyProvider.notifier);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _iconButton(
          context,
          icon: Icons.arrow_drop_down_rounded,
          onTap: onDownPressed,
        ),
        RichText(
          text: TextSpan(
            // text: currentPageCount.toString(),
            text: state.pageSize.toString(),
            style: context.headerText?.copyWith(
              color: AppColor.primary,
            ),
            children: <TextSpan>[
              TextSpan(
                text: " 개 만 보이기",
                style: context.bodyText?.copyWith(color: AppColor.borderColor),
              ),
            ],
          ),
        ).center,
        _iconButton(
          context,
          icon: Icons.arrow_drop_up_rounded,
          onTap: onUpPressed,
        ),
      ],
    );
  }

  Widget _iconButton(
    BuildContext context, {
    VoidCallback? onTap,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        size: 36,
      ),
    );
  }
}
