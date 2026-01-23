import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:rto_apps/Rto_Modals/rto_offices.dart';
import 'package:rto_apps/Screen/Settings/stateSelaction.dart';
import 'package:rto_apps/helper/app_colors.dart';
import 'package:rto_apps/helper/asset_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RtoOffices extends StatefulWidget {
  const RtoOffices({super.key});
  @override
  State<RtoOffices> createState() => _RtoOfficesState();
}

class _RtoOfficesState extends State<RtoOffices> {
  List<RtoOfficesModal> rtoOfficeList = [];
  Map<String, dynamic>? allStateRtoData;
  bool _isLoading = true;
  String selectedState = 'Maharashtra';

  @override
  void initState() {
    // TODO: implement initState
    loadingRtoOffices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homePageBackground,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.appBarColors,
        iconTheme: IconThemeData(color: AppColors.whiteColors),
        title: Text(
          'RTO OFFICES',
          style: TextStyle(
            color: AppColors.whiteColors,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.appBarColors),
          ))
          : rtoOfficeList.isEmpty
          ? SizedBox.shrink()
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Stateselaction(),
                        ),
                      );
                      if (result != null) {
                        selectedState = result;
                        setState(() {
                          rtoOfficeList = [];
                        });
                        getStateRtoList();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.appBarColors,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                selectedState,
                                style: TextStyle(
                                  color: AppColors.whiteColors,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            Icon(
                              Icons.arrow_drop_down,
                              size: 35,
                              color: AppColors.whiteColors,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                Expanded(
                  child: ExpandedTileList.separated(
                    itemCount: rtoOfficeList.length,
                    separatorBuilder: (context, index) =>
                        Divider(color: Colors.transparent),
                    itemBuilder: (context, index, controller) {
                      final rto = rtoOfficeList[index];
                      return ExpandedTile(
                        contentseparator: 1,
                        theme: ExpandedTileThemeData(
                          headerColor: AppColors.whiteColors,
                          contentBackgroundColor: AppColors.whiteColors,
                        ),
                        title: Text(
                          '${rto.code}-${rto.office}',
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 18,
                          ),
                        ),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.location_on),
                                SizedBox(width: 10),
                                Expanded(child: Text('${rto.address}')),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.phone, size: 23),
                                SizedBox(width: 10),
                                Expanded(child: Text('${rto.phone}')),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.email),
                                SizedBox(width: 10),
                                Expanded(child: Text('${rto.email}')),
                              ],
                            ),
                          ],
                        ),
                        controller: controller,
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> getStateRtoList() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    selectedState = sp.getString('selected_state') ?? selectedState;
    // final String state = sp.getString('selectedState') ?? 'Maharastra';
    final list = allStateRtoData?[selectedState];
    if (list != null && list is List) {
      rtoOfficeList = list.map((e) => RtoOfficesModal.fromJson(e)).toList();
    } else {
      rtoOfficeList = [];
    }

    setState(() {});
  }

  Future<void> loadingRtoOffices() async {
    setState(() {
      _isLoading = true;
    });
    final String response = await rootBundle.loadString(AppFile.rtoOffice);
    final Map<String, dynamic> data = json.decode(response);
    allStateRtoData = data;
    setState(() {
      _isLoading = false;
    });
    getStateRtoList();
  }
}
