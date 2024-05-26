import 'package:flutter/material.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Pages/User_Pages/all_services_page.dart';
import 'package:mahloula/Pages/User_Pages/bookmark_page.dart';
import 'package:mahloula/Pages/notifications_page.dart';
import 'package:mahloula/Pages/User_Pages/offers_page.dart';
import 'package:mahloula/Widgets/custom_all_services.dart';
import 'package:mahloula/Widgets/custom_offer_item.dart';



class OriginalPage extends StatelessWidget {
  OriginalPage({required this.name});
  final String name;
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
                onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BookmarkPage()));
                },
                icon: Icon(
                  Icons.bookmark_border,
                  size: 27,
                )),
            IconButton(
                onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationsPage()));
                },
                icon: Icon(
                  Icons.notifications_none,
                  size: 27,
                )),
          ],
        ),
        actions: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'صباح الخير',
                style: TextStyle(
                    color: Colors.grey, fontFamily: 'cairo', fontSize: 16),
              ),
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'cairo',
                  fontSize: 21.0,
                  //fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.account_circle,
              size: 45,
            ),
          )
        ],
      ),
      body: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Column(
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                          labelText: 'بحث',
                          labelStyle: const TextStyle(
                            color: Colors.black54,
                            fontSize: 24,
                            fontFamily: 'cairo',
                          ),
                          prefixIcon: IconButton(
                            onPressed: ()
                            {
                              // services.contains(searchController.text) ? print('success') : Navigator.push(context, MaterialPageRoute(builder: (context){
                              //   return NoResults();
                              // }));
                            },
                            icon: const Icon(
                              Icons.search_rounded,
                              color: Colors.black54,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.black54,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: ()
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OffersPage()));
                        },
                        child: Text(
                          'الكل',
                          style: TextStyle(
                              color: MainColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'cairo',
                              fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'عروض خاصة',
                          style: TextStyle(
                              fontFamily: 'cairo',
                              fontWeight: FontWeight.bold,
                              fontSize: 21.0,
                              color: Colors.grey.shade800),
                        ),
                      ),
                    ],
                  ),
                  CustomOfferItem(
                    text1: '30%',
                    text2: 'عروض اليوم',
                    text3: ' احصل علي عرض لكل طلب, صالح لليوم',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: ()
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AllServicesPage()));
                        },
                        child: Text(
                          'الكل',
                          style: TextStyle(
                              color: MainColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'cairo',
                              fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'الخدمات',
                          style: TextStyle(
                              fontFamily: 'cairo',
                              fontWeight: FontWeight.bold,
                              fontSize: 21.0,
                              color: Colors.grey.shade800),
                        ),
                      ),
                    ],
                  ),
                  CustomAllSercivces()
                ],
              ),
            ),
          ),
        ),
    );
  }
}
