import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rto_apps/Settings/contact_us.dart';
import 'package:rto_apps/Settings/privacy_policy.dart';
import 'package:rto_apps/Settings/process_driving_licence.dart';
import 'package:rto_apps/Settings/rto_offices.dart';
import 'package:rto_apps/Settings/stateSelaction.dart';
import 'package:rto_apps/helper/app_colors.dart';
import 'package:rto_apps/helper/asset_helper.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String appVersion = '';
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> get getSettingsList => [
    {
      'title': 'Form',
      'icons': Icons.description,
      'onTap': () {
        launchUrl(Uri.parse('https://parivahan.gov.in'));
      },
    },

    {
      'title': 'Process of Driving Licence',
      'icons': Icons.swap_horiz,
      'onTap': () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProcessDrivingLicence()),
        );
      },
    },
    {
      'title': 'RTO Office',
      'icons': Icons.business,
      'onTap': () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RtoOffices()),
        );
      },
    },
    {
      'title': 'Contact Us',
      'icons': Icons.email,
      'onTap': () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ContactUs()),
        );
      },
    },
    {
      'title': 'Add Driving School',
      'icons': Icons.navigation,
      'onTap': () {
        openNearbyDrivingSchool();
      },
    },
    {
      'title': 'Share App',
      'icons': Icons.share,
      'onTap': () {
        Share.share(
          'https://play.google.com/store/apps/details?id=com.avtechy.rto_apps',
        );
      },
    },
    {'title': 'Rate App', 'icons': Icons.star, 'onTap': () {}},
    {
      'title': 'Disclaimer',
      'icons': Icons.info,
      'onTap': () {
        showDisclaimerDialog();
      },
    },
    {
      'title': 'Privacy Policy',
      'icons': Icons.lock,
      'onTap': () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CommonWebView(
              title: 'Privacy Policy',
              url: 'https://rto-exam-9134e.web.app/privacy_policy.html',
            ),
          ),
        );
      },
    },
    {
      'title': 'Terms & Conditions',
      'icons': Icons.description,
      'onTap': () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CommonWebView(
              title: 'Terms & Conditions',
              url: 'https://rto-exam-9134e.web.app/terms_conditions.html',
            ),
          ),
        );
      },
    },
  ];

  @override
  void initState() {
    super.initState();
    // showDisclaimerDialog();
    loadAppVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homePageBackground,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColors,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.whiteColors),
        title: Text(
          'Settings & Help',
          style: TextStyle(
            color: AppColors.whiteColors,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Text(
                'Settings & Help',
                style: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 2,
              color: AppColors.whiteColors,
              margin: EdgeInsets.all(10),
              child: MediaQuery.removePadding(
                removeBottom: true,
                context: context,
                removeTop: true,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return getSettingMaterial(
                      title: getSettingsList[index]['title'],
                      icons: getSettingsList[index]['icons'],
                      onTap: getSettingsList[index]['onTap'],
                    );
                  },
                  separatorBuilder: (context, index) =>
                      Divider(color: Colors.black12, thickness: 1, height: 10),
                  itemCount: getSettingsList.length,
                ),
              ),
            ),

            SizedBox(height: 20),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                child: Text(
                  appVersion.isEmpty ? '' : appVersion,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getSettingMaterial({
    required String title,
    required IconData icons,
    required Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Icon(icons, size: 26, color: AppColors.appBarColors),
            SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_sharp,
              size: 24,
              color: AppColors.appBarColors,
            ),
          ],
        ),
      ),
    );
  }

  void showDisclaimerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.whiteColors,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          title: Text(
            'Disclaimer',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.appBarColors,
            ),
          ),
          content: Text(
            'This test is only for public awareness. Though all efforts have been made to ensure the accuracy of the content, the same should not be construed as a statement of law or used for any legal purpose. This application accepts no responsibility in relation to the accuracy, completeness, usefulness or otherwise, of the contents. Users are advised to verify check any information with the Transport Department.',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.blackColor,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.appBarColors,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> loadAppVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = 'Version ${info.version} (${info.buildNumber})';
    });
  }

  Future<void> openNearbyDrivingSchool() async {
    final Uri url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=driving+school+near+me',
    );
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch Google Maps';
    }
  }
}
