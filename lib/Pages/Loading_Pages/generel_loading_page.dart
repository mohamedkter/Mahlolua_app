import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GenerelLoadingPage extends StatelessWidget {
  const GenerelLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Container(width: 150,height: 150, child: Lottie.asset("assets/photo/loadingAnamation.json"))],
        ),
      ),
    );
  }
}
