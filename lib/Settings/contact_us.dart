import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rto_apps/helper/add_helper.dart';
import 'package:rto_apps/helper/app_colors.dart';
import 'package:rto_apps/widget/large_banner_widget.dart';
import 'package:rto_apps/widget/small_banner_widget.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});
  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  late BannerAd bannerAd;
  bool isAdLoaded = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  List<Map<String, dynamic>> get contactUsList => [
    {'title': 'Name', 'controller': nameController},
    {'title': 'Email', 'controller': emailController},
    {'title': 'Phone Number (Optional)', 'controller': phoneNumberController},
    {'title': 'City', 'controller': cityController},
    {'title': 'Message', 'controller': messageController},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColors,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColors,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.whiteColors),
        title: Text(
          'Contact Us',
          style: TextStyle(
            color: AppColors.whiteColors,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      bottomNavigationBar: SmallBannerWidget(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return TextFormField(
                      controller: contactUsList[index]['controller'],
                      maxLength:
                          contactUsList[index]['title'] ==
                              'Phone Number (Optional)'
                          ? 10
                          : null,
                      keyboardType:
                          (contactUsList[index]['title'] ==
                              'Phone Number (Optional)')
                          ? TextInputType.phone
                          : TextInputType.emailAddress,
                      inputFormatters:
                          contactUsList[index]['title'] ==
                              'Phone Number (Optional)'
                          ? [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ]
                          : null,
                      validator: (value) {
                        String title = contactUsList[index]['title'];
                        if (value == null || value.trim().isEmpty) {
                          if (title.contains('Optional')) {
                            return null;
                          }
                          return '$title is required';
                        }
                        if (title == 'Email') {
                          if (!RegExp(
                            r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                          ).hasMatch(value)) {
                            return 'Enter valid email';
                          }
                        }
                        if (title == 'Phone Number (Optional)') {
                          if (value == null || value.trim().isEmpty) {
                            return 'Phone number is required';
                          }

                          // 🔴 EXACT 10 DIGITS
                          if (value.length != 10) {
                            return 'Phone number must be exactly 10 digits';
                          }

                          // 🔴 INDIAN NUMBER VALIDATION
                          if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
                            return 'Enter valid Indian phone number';
                          }
                        }

                        return null;
                      },

                      decoration: InputDecoration(
                        label: getTextDetails(
                          title: contactUsList[index]['title'],
                        ),
                        border: OutlineInputBorder(),
                        counterText: '',
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      Divider(color: Colors.transparent),
                  itemCount: contactUsList.length,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _formKey.currentState!.reset();
                        for (var item in contactUsList) {
                          item['controller'].clear();
                        }
                      },
                      child: getContectUsButto(
                        title: 'RESET',
                        color: AppColors.appBarColors,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          await _sendDetailsTofirebase();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: AppColors.appBarColors,
                              content: Center(
                                child: Text(
                                  'Form Submitted Successfully',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.whiteColors,
                                  ),
                                ),
                              ),
                            ),
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: getContectUsButto(
                        title: 'SEND ',
                        color: AppColors.redColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              LargeBannerAdWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Future _sendDetailsTofirebase() async {
    final firestore = FirebaseFirestore.instance;
    await firestore.collection('contactUsQuery').add({
      'name': nameController.text,
      'email': emailController.text,
      'phoneNumber': phoneNumberController.text,
      'message': messageController.text,
      'city': cityController.text,
      'dateTime': Timestamp.now(),
    });
  }

  Card getContectUsButto({
    required String title,
    // required Function onTap,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
          child: Text(
            title,
            style: TextStyle(
              color: AppColors.whiteColors,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Text getTextDetails({required String title}) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  @override
  void initState() {
    // loadingRtoOffices();
    getBannerAd();
    super.initState();
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
