// title of offer in appbar
// image of offer
// detiles of offer
// how to get offer
//txet of description
// offer avalible to
// conditions
import 'package:flutter/material.dart';
import 'package:mahloula/Models/offer_model.dart';

class SpecificOfferPage extends StatelessWidget {
  Offer offer;
  SpecificOfferPage({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(offer.desc),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                width: double.infinity,
                height: 250,
                child: Image.asset(
                  offer.image,
                  fit: BoxFit.cover,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15 ,right: 11 ,bottom: 20),
                  child: Text(
                    ' تفاصيل العرض',
                    style: TextStyle(
                        fontFamily: 'cairo',
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                        color: Colors.grey.shade800),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
