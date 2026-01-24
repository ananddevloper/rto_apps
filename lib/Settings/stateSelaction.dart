import 'package:flutter/material.dart';
import 'package:rto_apps/helper/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Stateselaction extends StatefulWidget {
  const Stateselaction({super.key});

  @override
  State<Stateselaction> createState() => _StateselactionState();
}

class _StateselactionState extends State<Stateselaction> {
  List<String> get getStateList => [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Andaman and Nicobar Islands',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Chandigarh',
    'Dadra and Nagar Haveli and Daman and Diu',

    ///
    'Delhi',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Jammu and Kashmir',
    'Karnataka',
    'Kerala',
    'Ladakh', //
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

  List<String> filteredStateList = [];
  TextEditingController searchController = TextEditingController();

  @override
  initState() {
    super.initState();
    filteredStateList = getStateList; //initial me sab show hoga
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColors,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColors,
        iconTheme: IconThemeData(color: AppColors.whiteColors),
        title: Text(
          'Select Your State',
          style: TextStyle(
            color: AppColors.whiteColors,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          TextField(
            controller: searchController,
            onChanged: searchState, //ye zaroori hai
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search),
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.black54, fontSize: 20),
            ),
          ),
          Divider(),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    //Navigator.pop(context, filteredStateList[index]);
                    String selectedState = filteredStateList[index];
                    await saveSelectedState(selectedState);
                    Navigator.pop(context, selectedState);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(35, 10, 0, 10),
                    child: Text(
                      filteredStateList[index],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: filteredStateList.length,
            ),
          ),
        ],
      ),
    );
  }

  void searchState(String query) {
    final result = getStateList.where((State) {
      return State.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredStateList = result;
    });
  }

  Future<void> saveSelectedState(String state) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_state', state);
  }
}
