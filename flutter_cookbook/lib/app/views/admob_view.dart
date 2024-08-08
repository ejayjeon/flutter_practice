import 'dart:io';

import 'package:cookbook/app/const/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// https://docs.flutter.dev/cookbook/plugins/google-mobile-ads
// 1. AdMob App ID 부여받기 ex ca-app-pub-1234567890123456~1234567890
// 2. 플랫폼별로 셋업
// 3. flutter pub add google_mobile_ads
// 4. Mobile Ads SDK 초기화하기
// 5. 배너 불러오기
// 6. 배너 보여주기

class AdMobView extends StatelessWidget {
  const AdMobView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      appTitle: 'AdMob Indicator',
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (_, index) {
                return SizedBox(
                  child: Text('$index 번'),
                );
              },
              separatorBuilder: (_, index) {
                return const Divider();
              },
              itemCount: 50,
            ),
          ),
          SizedBox(
            height: 50.0,
            child: AdMob(),
          )
        ],
      ),
    );
  }
}

class AdMob extends StatefulWidget {
  AdMob({
    super.key,
    this.adSize = AdSize.banner,
  });
  final AdSize adSize;
  final String adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  @override
  State<AdMob> createState() => _AdMobState();
}

class _AdMobState extends State<AdMob> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  void _loadAd() {
    final bannerAd = BannerAd(
      size: widget.adSize,
      adUnitId: widget.adUnitId,
      request: const AdRequest(),
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    );

    // Start loading.
    bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: widget.adSize.width.toDouble(),
        height: widget.adSize.height.toDouble(),
        child: _bannerAd == null ? const SizedBox() : AdWidget(ad: _bannerAd!),
      ),
    );
  }
}
