import 'package:flutter/material.dart';

import '../../Constants/Color_Constants.dart';

class NotificationSettingsScreen extends StatefulWidget {
  @override
  _NotificationSettingsScreenState createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool generalNotifications = true;
  bool sound = false;
  bool vibration = false;
  bool specialOffers = true;
  bool privacy = true;
  bool appUpdates = false;
  bool newService = true;
  bool termsOfUse = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:  Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  const Text(
                    "الاشعارات",
                    style: TextStyle(
                        fontFamily: 'cairo',
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: MainColor,
                        borderRadius: BorderRadius.circular(10)),
                    width: 30,
                    height: 30,
                  )
                ],
              )
            ],
          ),
        ),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildToggleSwitch('إشعارات عامة', generalNotifications, (value) {
              setState(() {
                generalNotifications = value;
              });
            }),
            buildToggleSwitch('الصوت', sound, (value) {
              setState(() {
                sound = value;
              });
            }),
            buildToggleSwitch('الاهتزاز', vibration, (value) {
              setState(() {
                vibration = value;
              });
            }),
            buildToggleSwitch('عروض خاصة', specialOffers, (value) {
              setState(() {
                specialOffers = value;
              });
            }),
            buildToggleSwitch('خصوصيات', privacy, (value) {
              setState(() {
                privacy = value;
              });
            }),
            buildToggleSwitch('تحديثات التطبيق', appUpdates, (value) {
              setState(() {
                appUpdates = value;
              });
            }),
            buildToggleSwitch('خدمة جديدة', newService, (value) {
              setState(() {
                newService = value;
              });
            }),
            buildToggleSwitch('تعليمات استخدام', termsOfUse, (value) {
              setState(() {
                termsOfUse = value;
              });
            }),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MainColor, // Set the background color to blue
              ),
              onPressed: () {

              },

              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 10.0),
                child: Text('حفظ التعديلات',style: TextStyle(
                    fontFamily: 'cairo',
                    fontSize: 21.0,
                    color: Colors.white
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildToggleSwitch(String title, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: MainColor,
            inactiveThumbColor: Colors.grey[600],
          ),
          Text(title,style: TextStyle(
            fontSize: 19.0,
            fontFamily: 'cairo',
            fontWeight: FontWeight.bold
          ),),
        ],
      ),
    );
  }
}