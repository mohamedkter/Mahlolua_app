import 'package:flutter/material.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Models/sponsor_model.dart';
import 'package:mahloula/Widgets/custom_offer_item.dart';

class OffersPage extends StatelessWidget {
  const OffersPage({Key? key, required this.sponsors}) : super(key: key);
  final List<Sponsor> sponsors;

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
        itemBuilder: (context, index) => CustomOfferItem(text1: '${sponsors[index].title}',bgImage:PartImagePath+sponsors[index].image,),
        itemCount: sponsors.length,
      ),
    );
  }
}
