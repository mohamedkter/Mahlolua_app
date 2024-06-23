// title of offer in appbar
// image of offer
// detiles of offer
// how to get offer
//txet of description
// offer avalible to
// conditions
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Models/sponsor_model.dart';

class SpecificOfferPage extends StatelessWidget {
  Sponsor offer;
  SpecificOfferPage({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(offer.desc),
        titleTextStyle: TextStyle(
                        fontFamily: 'cairo',
                        fontWeight: FontWeight.w700,
                        fontSize: 19.0,
                        color: Colors.grey.shade800),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                width: double.infinity,
                height: 250,
                child: Image.network(
                  PartImagePath + offer.image,
                  fit: BoxFit.cover,
                )),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: 15, right: 11, bottom: 20),
                  child: Text(
                    ' تفاصيل العرض',
                    style: TextStyle(
                        fontFamily: 'cairo',
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                        color: MainColor),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 11, bottom: 20),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      width: MediaQuery.of(context).size.width/1.1,
                      child: Text(
                        offer.desc ,
                        style: TextStyle(
                          fontFamily: 'cairo',
                          fontWeight: FontWeight.w700,
                          fontSize: 17.0,
                          color: Colors.grey.shade800,
                        ),
                        maxLines: 4,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 11, bottom: 20),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      width: MediaQuery.of(context).size.width/1.1,
                      child: Text(
                      "ينتهي بعد ${Jiffy.now().to(Jiffy.parse(offer.expired_at)).toString()}",
                      style: TextStyle(
                        fontFamily: "Cairo",
                        fontSize: 17,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w600,
                      ),)
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
