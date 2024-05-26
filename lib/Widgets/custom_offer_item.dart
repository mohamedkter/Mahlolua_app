import 'package:flutter/material.dart';

class CustomOfferItem extends StatelessWidget {
  const CustomOfferItem({
    super.key, required this.text1, required this.text2, required this.text3,
  });
  final String text1;
  final String text2;
  final String text3;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(11.0),
      child: Container(
        width: double.infinity,
        height: 170,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.blue.shade900,
            borderRadius: BorderRadius.circular(18.0)),
        child: Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text1,
                style: TextStyle(
                  fontSize: 49.0,
                  fontFamily: 'cairo',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                text2,
                style: TextStyle(
                  fontSize: 23.0,
                  fontFamily: 'cairo',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                text3,
                style: TextStyle(
                  //fontSize: 21.0,
                  fontFamily: 'cairo',
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}