import 'package:flutter/material.dart';

class CustomOfferItem extends StatelessWidget {
  const CustomOfferItem({
    super.key, required this.text1, required this.bgImage,
  });
  final String text1;
  final String bgImage;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(11.0),
      child: Container(
        width: double.infinity,
        height: 170,
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(bgImage,),fit: BoxFit.cover),
            shape: BoxShape.rectangle,
            color: Colors.blue.shade900,
            borderRadius: BorderRadius.circular(18.0)),
        child: Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            
    
            ],
          ),
        ),
      ),
    );
  }
}