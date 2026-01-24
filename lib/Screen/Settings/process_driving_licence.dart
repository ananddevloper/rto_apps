import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rto_apps/helper/app_colors.dart';
import 'package:rto_apps/helper/asset_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProcessDrivingLicence extends StatefulWidget {
  const ProcessDrivingLicence({super.key});
  @override
  State<ProcessDrivingLicence> createState() => _ProcessDrivingLicenceState();
}

class _ProcessDrivingLicenceState extends State<ProcessDrivingLicence> {
   WebViewController? controller;
  String htmlData = '';
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
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
      body: _isLoading? Center(child: CircularProgressIndicator(),) :WebViewWidget(controller: controller!),
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
}
