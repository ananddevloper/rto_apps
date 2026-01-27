import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rto_apps/helper/add_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InterstitialAdManager {
  static InterstitialAd? _interstitialAd;
  static bool _isAdLoaded = false;

  /// Load Ad
  static void loadAd() {
    InterstitialAd.load(
      adUnitId: AddHelper.interstitialAdId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isAdLoaded = true;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              loadAd();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              loadAd();
            },
          );
        },
        onAdFailedToLoad: (error) {
          _interstitialAd = null;
          _isAdLoaded = false;
        },
      ),
    );
  }

  /// Show Ad
  static void showAd({required Function() onAdClosed, bool? showAd}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    int interstitialCounter = sp.getInt('interstitialCounter') ?? 1;
    if (interstitialCounter % 3 != 0 && showAd == false) {
      interstitialCounter++;
      await sp.setInt('interstitialCounter', interstitialCounter);
      onAdClosed();
      return;
    }

    if (_isAdLoaded && _interstitialAd != null) {
      _interstitialAd!.show();
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) async {
          ad.dispose();
          loadAd();
          interstitialCounter++;
          await sp.setInt('interstitialCounter', interstitialCounter);
          onAdClosed();
        },
      );
    } else {
      onAdClosed();
    }
  }
}
