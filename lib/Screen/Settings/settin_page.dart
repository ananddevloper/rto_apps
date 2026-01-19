import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rto_apps/helper/app_colors.dart';
import 'package:rto_apps/helper/asset_helper.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController searchController = TextEditingController();

  List<String> get filteredStates {
    if (searchController.text.isEmpty) {
      return getStateList;
    }
    return getStateList
        .where(
          (state) =>
              state.toLowerCase().contains(searchController.text.toLowerCase()),
        )
        .toList();
  }

  List<String> get getStateList => [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Andaman and Nicobar Islands',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Chandigarh',
    'Dadra and Nagar Haveli and Daman and Diu',
    'Delhi',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Jammu and Kashmir',
    'Karnataka',
    'Kerala',
    'Ladakh',
    'Lakshadweep',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Puducherry',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
  ];

  List<Map<String, dynamic>> get getSettingsList => [
    {
      'title': 'Change State',
      'icons': Icons.location_on,
      'onTap': () {
        showModalBottomSheet(
          backgroundColor: AppColors.homePageBackground,
          context: context,
          isScrollControlled: true,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.85,
          ),
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  getSelectState(),
                  Divider(),
                  TextField(
                    controller: searchController,
                    onChanged: (_) {
                      setState(() {

                      });
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, size: 30),
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.black54, fontSize: 20),
                    ),
                  ),
                  Divider(),
                  Expanded(child: getChangeState()),
                ],
              ),
            );
          },
        );
      },
    },
    {'title': 'Change Language', 'icons': Icons.translate, 'onTap': () {}},
    {'title': 'Dark Mode', 'icons': Icons.dark_mode, 'onTap': () {}},
    {'title': 'Form', 'icons': Icons.description, 'onTap': () {}},
    {
      'title': 'Proceess of Driving Licence',
      'icons': Icons.swap_horiz,
      'onTap': () {},
    },
    {'title': 'RTO Office', 'icons': Icons.business, 'onTap': () {}},
    {'title': 'Contact Us', 'icons': Icons.email, 'onTap': () {}},
    {'title': 'Add Driving School', 'icons': Icons.navigation, 'onTap': () {}},
    {'title': 'Share App', 'icons': Icons.share, 'onTap': () {}},
    {'title': 'Rate App', 'icons': Icons.star, 'onTap': () {}},
    {'title': 'Disclaimer', 'icons': Icons.info, 'onTap': () {}},
    {'title': 'Privacy Policy', 'icons': Icons.lock, 'onTap': () {}},
    {'title': 'Terms & Conditions', 'icons': Icons.description, 'onTap': () {}},
  ];

  ListView getChangeState() {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 0, 20),
          child: Text(
            filteredStates[index],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => Divider(),
      itemCount: filteredStates.length,
    );
  }

  Padding getSelectState() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            textAlign: TextAlign.start,
            'Select State',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),

          Icon(Icons.close),
        ],
      ),
    );
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
              child: Text(
                'Version 3.50(112)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: onTap,
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
}
