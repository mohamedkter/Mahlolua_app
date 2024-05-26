import 'package:flutter/material.dart';
import 'package:mahloula/Widgets/custom_offer_item.dart';

class OffersPage extends StatelessWidget {
  const OffersPage({Key? key}) : super(key: key);
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
            'العروض',
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
      body: ListView.builder(
        itemBuilder: (context, index) => CustomOfferItem(text1: 'text1', text2: 'text2', text3: 'text3'),
        itemCount: 10,
      ),
    );
  }
}
