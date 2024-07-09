import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Pages/Auth_Pages/login_page.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key, required this.upperMessage, required this.lowerMessage, required this.imageParh});
final String imageParh;
final String upperMessage;
final String lowerMessage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 250,
                height: 250,
                child: Lottie.asset(
                  'assets/photo/DoneAnamition.json',
                  fit: BoxFit.cover,
                )),
             Text(
              upperMessage,
              style: const TextStyle(
                  color: MainColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: "cairo",
                  fontSize: 20),
            ),
             Text(
              "$lowerMessage",
              style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontFamily: "cairo",
                  fontSize: 15),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: const Text(
                  "العوده لتسجيل الدخول",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontFamily: "cairo"),
                ))
          ],
        )),
      ),
    );
  }
}
