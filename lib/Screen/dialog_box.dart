import 'package:flutter/material.dart';
import 'package:rto_apps/helper/app_colors.dart';
import 'package:rto_apps/widget/reward_ad_helper.dart';

class StartExamDialog {
  static Future<void> show({
    required BuildContext context,
    required VoidCallback onStart,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.whiteColors,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: CircleAvatar(
            radius: 40,
            backgroundColor: AppColors.appBarColors,
            child: Icon(Icons.lock, color: AppColors.whiteColors, size: 40),
          ),
          content: Text(
            'Watch ads and get free test attempts.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // close dialog
              },
              child: const Text('NO THANKS'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.appBarColors,
              ),
              onPressed: () {
                Navigator.pop(context); // close dialog
                onStart(); // callback
                
              },
              child: const Text(
                'WATCH NOW',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
