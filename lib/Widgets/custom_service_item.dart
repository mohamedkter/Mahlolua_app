import 'package:flutter/material.dart';
import 'package:mahloula/Pages/User_Pages/specific_service_page.dart';

class CustomServiceItem extends StatelessWidget {
  const CustomServiceItem({
    required this.serviceName,
    required this.imageSource,
  });
  final String serviceName;
  final String imageSource;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: ()
          {
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return SpecificServicePage(name: serviceName,);
            }));
          },
          icon: CircleAvatar(
            radius: 25,
            child: Image.asset(
              imageSource,
              width: 55,
              height: 55,
            ),
          ),
        ),
        Text(
          serviceName,
          style: TextStyle(fontSize: 16, fontFamily: 'cairo'),
        )
      ],
    );
  }
}