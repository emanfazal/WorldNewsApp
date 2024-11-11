import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/ui/SettingsScreen/SettingLogic.dart';

class Settingview extends StatelessWidget {
  Settingview({super.key});
  final controller = Get.put(SettingLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Center(
          child: Text(
            'Hi , ${controller.userName.value}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Logout Button
            InkWell(
              onTap: () async {
                await controller.showConfirmDialog(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  height: 60,
                  width: 250,
                  child: Card(
                    color: Color(0xFF215273),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        'LogOut',
                        style: GoogleFonts.poppins(
                          color: Color(0xFFCFF4D2),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // App Information Section
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.info, color: Colors.blue),
                    title: Text(
                      'App Version',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('1.0.0'), // Replace with actual app version
                  ),
                  ListTile(
                    leading: Icon(Icons.contact_support, color: Colors.green),
                    title: Text(
                      'Contact Us',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('support@newsapp.com'), // Replace with actual contact
                  ),
                  ListTile(
                    leading: Icon(Icons.article, color: Colors.orange),
                    title: Text(
                      'Terms & Conditions',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      // Navigate to Terms & Conditions page
                    },
                  ),
                ],
              ),
            ),

            // Other Options Section
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.feedback, color: Colors.purple),
                    title: Text(
                      'Send Feedback',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      // Navigate to feedback screen or open feedback form
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.star, color: Colors.yellow[700]),
                    title: Text(
                      'Rate the App',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      // Redirect to app store for rating
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.share, color: Colors.red),
                    title: Text(
                      'Invite Friends',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      // Implement share functionality
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
