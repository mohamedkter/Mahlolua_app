import 'package:flutter/material.dart';
import 'package:mahloula/Widgets/service_card.dart';
import 'package:mahloula/Pages/User_Pages/service_provider_page.dart';

class SpecificServicePage extends StatelessWidget {
  const SpecificServicePage({Key? key, required this.name}) : super(key: key);
  final String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: IconButton(
          onPressed: () {},
          icon: CircleAvatar(
            radius: 17,
            child: Icon(
              Icons.more_horiz,
            ),
            backgroundColor: Colors.grey.shade200,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Text(
            name,
            style: TextStyle(
              fontFamily: 'cairo',
              fontSize: 27.0,
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_forward,
                size: 30,
              ))
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.builder(
            itemBuilder: (context, index) => GestureDetector(
              child: ServiceCard(NumberResidents: 1200,Price: 135,ProvidedService: "صيانه تكيف",rate: 3.5,ServiceProviderName: "محمد محمود",ToDoFunction: (){print("bookmarked");},),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ServiceProviderPage()));
              },
            ),
            itemCount: 50,
          )),
    );
  }
}
