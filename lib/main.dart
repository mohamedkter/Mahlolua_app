import 'package:flutter/material.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Pages/Service_Provider_Pages/service_provider_credentials_page.dart';
import 'package:mahloula/Pages/Service_Provider_Pages/service_provider_main_page.dart';
import 'package:mahloula/Pages/Service_Provider_Pages/service_provider_profile_page.dart';
import 'package:mahloula/Pages/User_Pages/get_location_page.dart';
import 'package:mahloula/Pages/User_Pages/home_page.dart';
import 'package:mahloula/Pages/help_center1_page.dart';
import 'package:mahloula/Pages/help_center_page.dart';
import 'package:mahloula/Pages/notifications_page.dart';
import 'package:mahloula/Pages/privacy_policy_page.dart';
import 'package:mahloula/Pages/welcome_page_one.dart';
import 'package:mahloula/Pages/welcome_page_two.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: MainColor,
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MainColor, width: 2.0),
          ),
        ),
      ),

      home:
      //GetLocationPage(),
      //ServiceProviderCredentials(),
      //HelpCenterPage()
      //WelcomePageTwo()
       HomePage(name: "ahmed"),
      //WelcomePageOne(),
      //ServiceProviderMainPage(name: "Ahmed")
    );
  }
}
