import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rto_apps/helper/add_helper.dart';

class RewardAdHelper {
  static RewardedAd? rewardedAd;
  static bool isLoaded = false;

  static void loadAd() {
    RewardedAd.load(
      adUnitId: AddHelper.rewardedAdId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          rewardedAd = ad;
          isLoaded = true;
        },
        onAdFailedToLoad: (error) {
          print(  'RewardedAd failed to load: $error');
          rewardedAd = null;
          isLoaded = false;
        },
      ),
    );
  }
  static void showAd({required Function(int rewardAmount) onRewardEarned}) {
    if (isLoaded && rewardedAd != null) {
      rewardedAd!.show(
        onUserEarnedReward: (ad, reward) {
          onRewardEarned(reward.amount.toInt());
        },
      );
      rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          loadAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          loadAd();
        },
      );
    }
  }
}
