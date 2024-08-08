import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sketch_pay/src/shared/types/typedef.dart';

abstract class ScrollEvent {
  Future<void> fetchMore(int index);
}

mixin ScrollControllerMixin<T extends ConsumerStatefulWidget> on State<T>
    implements ScrollEvent {
  late ScrollController _scrollController;
  late ScrollController _secondScrollController;
  bool needUp = false;
  bool toLeft = false;
  bool toRight = false;
  Timer? _debounce;
  double _scrollPosition = 0.0;

  ScrollController get scrollController => _scrollController;

  /// 두 개 필요할 때 꺼내 쓰도록 한 개 더 만듦..
  ScrollController get secondScrollController => _secondScrollController;

  Timer? get debounce => _debounce;
  double get scrollPosition => _scrollPosition;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _secondScrollController = ScrollController();
    _scrollController.addListener(scrollListener);
    _secondScrollController.addListener(secondScrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollController.removeListener(scrollListener);
    _secondScrollController.dispose();
    _secondScrollController.removeListener(secondScrollListener);
    _debounce?.cancel();
    super.dispose();
  }

  void scrollListener() {
    _scrollPosition = _scrollController.position.pixels;

    // double maxScroll = _scrollController.position.maxScrollExtent;
    // double scrollThreshold = 0.2;
    // if (_scrollController.offset >= maxScroll * scrollThreshold &&
    //     !_scrollController.position.outOfRange) {
    //   // 위로 보내기
    //   needUp = true;
    //   // _scrollController.animateTo(
    //   //   0.0,
    //   //   duration: const Duration(milliseconds: 500),
    //   //   curve: Curves.bounceIn,
    //   // );
    // }
    // needUp = false;
  }

  void secondScrollListener() {}

  void scrollDebouncer(AsyncVoidCallback func) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 1), func);
  }

  void goToSnapshotPosition() {
    if (_scrollPosition != 0.0) {
      _scrollController.animateTo(
        _scrollPosition,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      // _scrollController.jumpTo(_scrollPosition);
    }
  }

  @override
  Future<void> fetchMore(int index) {
    // TODO: implement fetchMore
    throw UnimplementedError();
  }
}
