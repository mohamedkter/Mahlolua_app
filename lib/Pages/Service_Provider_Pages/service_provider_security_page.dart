import 'package:flutter/material.dart';

import '../../Constants/Color_Constants.dart';

class SecuritySettingsScreen extends StatefulWidget {
  @override
  _SecuritySettingsScreenState createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  bool remember = true;
  bool faceLock = false;
  bool fingerprintLock = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    "الأمان",
                    style: TextStyle(
                        fontFamily: 'cairo',
                        letterSpacing: 1,
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
            buildToggleSwitch('تذكاري', remember, (value) {
              setState(() {
                remember = value;
              });
            }),
            buildToggleSwitch('قفل الوجه', faceLock, (value) {
              setState(() {
                faceLock = value;
              });
            }),
            buildToggleSwitch('قفل البصمة', fingerprintLock, (value) {
              setState(() {
                fingerprintLock = value;
              });
            }),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Implement login pin action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MainColor,
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              ),
              child: Text('رمز الدخول', style: TextStyle(color: Colors.white,fontFamily: 'cairo')),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Implement change password action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MainColor,
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              ),
              child: Text('تغيير كلمة السر', style: TextStyle(color: Colors.white,fontFamily: 'cairo')),
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