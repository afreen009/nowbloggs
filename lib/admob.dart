import 'dart:io';

class AdMobService {
  static String appId = 'ca-app-pub-1718282816355121~6679964972';
  static String bannerId = 'ca-app-pub-1718282816355121/2557721287';
  static String interstitialId = 'ca-app-pub-1718282816355121/2557721287';
  static String rewardId = 'ca-app-pub-1718282816355121/2368541647';
  String getAdMobAppId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-1718282816355121~1682675195';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-1718282816355121~6679964972';
    }
    return null;
  }

  String getBannerAppId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-1718282816355121/7042797177';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-1718282816355121/2557721287';
    }
    return null;
  }

  String getInterstitialAppId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-1718282816355121/5753782143';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-1718282816355121/8548414563';
    }
    return null;
  }

  String getRewarded() {
    if (Platform.isIOS) {
      return 'ca-app-pub-1718282816355121/1814537130';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-1718282816355121/2368541647';
    }
    return null;
  }
}
