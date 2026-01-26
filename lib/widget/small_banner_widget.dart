import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rto_apps/helper/add_helper.dart';

class SmallBannerWidget extends StatefulWidget {
  const SmallBannerWidget({super.key});

  @override
  State<SmallBannerWidget> createState() => _SmallBannerWidgetState();
}

class _SmallBannerWidgetState extends State<SmallBannerWidget> {
  BannerAd? _ad;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();

    _ad = BannerAd(
      adUnitId: AddHelper.bannerAdId, // 🔴 Use real ID in prod
      size: AdSize.banner, // 320x100
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
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
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
