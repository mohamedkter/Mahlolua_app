import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Pages/User_Pages/home_page.dart';
import 'package:mahloula/Pages/Auth_Pages/login_page.dart';
import 'package:mahloula/Services/Data/cache_data.dart';

import 'Pages/User_Pages/welcome_page_one.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheData.cacheInitialization();
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
    

       home:CacheData.getData(key:"token")==null?const LoginPage():HomePage(name:"${CacheData.getData(key: "name")}"),

    );
  }
}
