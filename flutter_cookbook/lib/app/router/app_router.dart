import 'package:cookbook/app/views/admob_view.dart';
import 'package:cookbook/app/views/appBarTab_view.dart';
import 'package:cookbook/app/views/changeWidget_view.dart';
import 'package:cookbook/app/views/dismissItem_view.dart';
import 'package:cookbook/app/views/downloadButton_view.dart';
import 'package:cookbook/app/views/dragElement_view.dart';
import 'package:cookbook/app/views/dragWidget_view.dart';
import 'package:cookbook/app/views/expandableFABWithFlow_view.dart';
import 'package:cookbook/app/views/expandableFAB_view.dart';
import 'package:cookbook/app/views/filterCarousel_view.dart';
import 'package:cookbook/app/views/gradientChatBubble_view.dart';
import 'package:cookbook/app/views/home_view.dart';
import 'package:cookbook/app/views/kcb_pass_view.dart';
import 'package:cookbook/app/views/loadingImage_view.dart';
import 'package:cookbook/app/views/parallaxCarousel_view.dart';
import 'package:cookbook/app/views/shimmer_view.dart';
import 'package:cookbook/app/views/staggerMenu_view.dart';
import 'package:cookbook/app/views/typingIndicator_view.dart';
import 'package:cookbook/app/views/videoPlayer_view.dart';
import 'package:get/route_manager.dart';

class Routes {
  static const HOME = '/home';
  static const DRAG_WIDGET = '/page1';
  static const CHANGE_WIDGET = '/page2';
  static const APPBAR_TAB = '/page3';
  static const DOWNLOAD_BUTTON = '/page4';
  static const FILTER_CAROUSEL = '/page5';
  static const PARALLAX_CAROUSEL = '/page6';
  static const SHIMMER = '/page7';
  static const STAGGER_MENU = '/page8';
  static const TYPING_INDICATOR = '/page9';
  static const EXPANDABLE_FAB = '/page10';
  static const GRADIENT_CHAT_BUBBLE = '/page11';
  static const DRAG_ELEMENT = '/page12';
  static const DISMISS_ITEM = '/page13';
  static const LOADING_IMAGE = '/page14';
  static const VIDEO_PLAYER = '/page15';
  static const ADMOB = '/page16';
  static const EXPANDABLE_FAB_WITH_FLOW = '/page17';
  static const KCB_PASS = '/page18';
  static const KCB_PASS2 = '/page19';
}

class AppRouter {
  AppRouter._();

  static const initPath = Routes.HOME;
  static final pages = <GetPage>[
    GetPage(name: Routes.HOME, page: () => const HomeView()),
    GetPage(name: Routes.DRAG_WIDGET, page: () => const DragWidget()),
    GetPage(name: Routes.CHANGE_WIDGET, page: () => const ChangeWidget()),
    GetPage(name: Routes.APPBAR_TAB, page: () => const AppBarTab()),
    GetPage(
        name: Routes.DOWNLOAD_BUTTON, page: () => const DownloadButtonView()),
    GetPage(name: Routes.FILTER_CAROUSEL, page: () => const FilterCarousel()),
    GetPage(
        name: Routes.PARALLAX_CAROUSEL,
        page: () => const ParallaxCarouselView()),
    GetPage(name: Routes.SHIMMER, page: () => const ShimmerView()),
    GetPage(name: Routes.STAGGER_MENU, page: () => const StaggerMenu()),
    GetPage(
        name: Routes.TYPING_INDICATOR, page: () => const TypingIndicatorView()),
    GetPage(name: Routes.EXPANDABLE_FAB, page: () => const ExpandableFABView()),
    GetPage(
        name: Routes.GRADIENT_CHAT_BUBBLE,
        page: () => const GradientChatBubbleView()),
    GetPage(name: Routes.DRAG_ELEMENT, page: () => const DragElementView()),
    GetPage(name: Routes.DISMISS_ITEM, page: () => const DismissItemView()),
    GetPage(name: Routes.LOADING_IMAGE, page: () => const LoadingImageView()),
    GetPage(name: Routes.VIDEO_PLAYER, page: () => const VideoPlayerView()),
    GetPage(name: Routes.ADMOB, page: () => AdMobView()),
    GetPage(
        name: Routes.EXPANDABLE_FAB_WITH_FLOW,
        page: () => const ExpandableFABWithFlowView()),
    GetPage(name: Routes.KCB_PASS, page: () => const KcbPassView()),
    GetPage(name: Routes.KCB_PASS2, page: () => KcbPass()),
  ];
}
