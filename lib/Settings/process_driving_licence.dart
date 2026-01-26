import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rto_apps/helper/add_helper.dart';
import 'package:rto_apps/helper/app_colors.dart';
import 'package:rto_apps/helper/asset_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProcessDrivingLicence extends StatefulWidget {
  const ProcessDrivingLicence({super.key});
  @override
  State<ProcessDrivingLicence> createState() => _ProcessDrivingLicenceState();
}

class _ProcessDrivingLicenceState extends State<ProcessDrivingLicence> {
 late BannerAd bannerAd;
  bool isAdLoaded = false;  
  WebViewController? controller;
  String htmlData = '';
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    getBannerAd();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadHtmlData();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homePageBackground,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.whiteColors),
        backgroundColor: AppColors.appBarColors,
        title: Text(
          'Process of Driving Licence',
          style: TextStyle(
            color: AppColors.whiteColors,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      bottomNavigationBar: isAdLoaded
          ? SizedBox(
              height: bannerAd.size.height.toDouble(),
              width: bannerAd.size.width.toDouble(),
              child: AdWidget(ad: bannerAd),
            )
          : null,
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : WebViewWidget(controller: controller!),
    );
  }

  Future<void> loadHtmlData() async {
    setState(() {
      _isLoading = true;
    });
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    final String html = await rootBundle.loadString(AppHtml.drivingProcessure);
    controller?.loadHtmlString(html);
    setState(() {
      _isLoading = false;
    });
  }


 
Future<void> getBannerAd() async {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AddHelper.bannerAdId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            isAdLoaded = true;
          });
        },
      ),
      request: const AdRequest(),
    );
    bannerAd.load();
  }


}
