import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rto_apps/helper/add_helper.dart';

class LargeBannerAdWidget extends StatefulWidget {
  const LargeBannerAdWidget({super.key});

  @override
  State<LargeBannerAdWidget> createState() => _LargeBannerAdWidgetState();
}

class _LargeBannerAdWidgetState extends State<LargeBannerAdWidget> {
  BannerAd? _ad;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();

    _ad = BannerAd(
      adUnitId: AddHelper.largeBannerAdId, // 🔴 Use real ID in prod
      size: AdSize.largeBanner, // 320x100
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) => setState(() => _isLoaded = true),
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded) {
      return const SizedBox(height: 100);
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.center,
      child: SizedBox(
        width: _ad!.size.width.toDouble(),
        height: _ad!.size.height.toDouble(),
        child: AdWidget(ad: _ad!),
      ),
    );
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }
}
