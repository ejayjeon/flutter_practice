import 'package:cookbook/app/const/app_layout.dart';
import 'package:cookbook/app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      appTitle: 'HOME',
      body: LimitedBox(
        maxWidth: Get.width,
        maxHeight: Get.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 24),
              _navigaterButton(
                  name: '위젯 드래그로 위치 옮기기', path: Routes.DRAG_WIDGET),
              _navigaterButton(
                  name: '버튼 눌러서 랜덤으로 위젯 변경시키기', path: Routes.CHANGE_WIDGET),
              _navigaterButton(name: '앱바에 탭바 이용하기', path: Routes.APPBAR_TAB),
              _navigaterButton(
                  name: '버튼 눌러서 다운로드하기', path: Routes.DOWNLOAD_BUTTON),
              _navigaterButton(
                  name: '사진에 필터 씌우기', path: Routes.FILTER_CAROUSEL),
              _navigaterButton(
                  name: '파라노마 필름 효과', path: Routes.PARALLAX_CAROUSEL),
              _navigaterButton(name: '스켈레톤 효과 (Shimmer)', path: Routes.SHIMMER),
              _navigaterButton(name: '뒤틀린 햄버거 메뉴', path: Routes.STAGGER_MENU),
              _navigaterButton(
                  name: '타이핑할 때 ...', path: Routes.TYPING_INDICATOR),
              _navigaterButton(name: 'FAB 애니메이션', path: Routes.EXPANDABLE_FAB),
              _navigaterButton(
                  name: 'Flow Widget 으로 만든 FAB',
                  path: Routes.EXPANDABLE_FAB_WITH_FLOW),
              _navigaterButton(
                  name: '그라데이션 채팅창', path: Routes.GRADIENT_CHAT_BUBBLE),
              _navigaterButton(
                  name: '드래그해서 아이템 옮기기', path: Routes.DRAG_ELEMENT),
              _navigaterButton(name: '드래그로 아이템 지우기', path: Routes.DISMISS_ITEM),
              _navigaterButton(
                  name: '이미지 로딩 중 인디게이터', path: Routes.LOADING_IMAGE),
              _navigaterButton(name: '비디오 플레이어', path: Routes.VIDEO_PLAYER),
              _navigaterButton(name: '애드몹 추가하는 방법', path: Routes.ADMOB),
              _navigaterButton(name: 'PASS 인증하는 방법', path: Routes.KCB_PASS),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navigaterButton({
    required String name,
    required String path,
  }) {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: () {
          Get.toNamed(path);
        },
        child: Text(name),
      ),
    );
  }
}
