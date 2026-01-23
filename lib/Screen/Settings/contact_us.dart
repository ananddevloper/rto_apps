import 'package:flutter/material.dart';
import 'package:rto_apps/helper/app_colors.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});
  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
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

      body: Padding(
        padding: const EdgeInsets.fromLTRB(18, 30, 18, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return TextFormField(
                      controller: contactUsList[index]['controller'],
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
                        if (title == 'Phone Number (Optional)' &&
                            value.isNotEmpty) {
                          if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value.trim())) {
                            return 'Enter valid phone number';
                          }
                        }
                        return null;
                      },
          
                      decoration: InputDecoration(
                        label: getTextDetails(
                          title: contactUsList[index]['title'],
                        ),
                        border: OutlineInputBorder(),
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
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: AppColors.appBarColors,
                              content: Center(
                                child: Text(
                                  'Form Submitted Successfully',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,color: AppColors.whiteColors
                                  ),
                                ),
                              ), 
                            ),
                          );
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
            ],
          ),
        ),
      ),
    );
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
}
