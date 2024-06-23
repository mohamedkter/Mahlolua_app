import 'package:flutter/material.dart';
import 'package:mahloula/Widgets/custom_all_services.dart';

class AllServicesPage extends StatelessWidget {
  const AllServicesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: IconButton(
          onPressed: () {},
          icon: CircleAvatar(
            radius: 17,
            backgroundColor: Colors.grey.shade200,
            child:const Icon(
              Icons.more_horiz,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
         const Text(
            'الخدمات',
            style: TextStyle(
              fontFamily: 'cairo',
              fontSize: 27.0,
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_forward,
                size: 30,
              ))
        ],
      ),
      body:  Padding(
        padding: EdgeInsets.all(8.0),
        child: CustomAllSercivces(services: [],),
      ),
    );
  }
}
