import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:shimmer/shimmer.dart';

class OriginalLoadingPage extends StatelessWidget {
  const OriginalLoadingPage({super.key});

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
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => BookmarkPage()));
                },
                icon: const Icon(
                  Icons.bookmark_border,
                  size: 27,
                )),
            IconButton(
                onPressed: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationsPage()));
                },
                icon: const Icon(
                  Icons.notifications_none,
                  size: 27,
                )),
          ],
        ),
        actions: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'صباح الخير',
                style: TextStyle(
                    color: Colors.grey, fontFamily: 'cairo', fontSize: 16),
              ),
              Text(
                "",
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
      body: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              children: [
                Container(
                  height: 65,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "بحث",
                        style: TextStyle(fontFamily: "cairo", fontSize: 25),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10, left: 10),
                        child: Icon(Icons.search),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'الكل',
                      style: TextStyle(
                          color: MainColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'cairo',
                          fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
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
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Container(
                    width: double.infinity,
                    height: 170,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(18.0)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'الكل',
                      style: TextStyle(
                          color: MainColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'cairo',
                          fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 15),
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
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4, mainAxisExtent: 110),
                    itemBuilder: (context, index) => Column(
                      children: [
                        Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(30))),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(width: 50, height: 5, color: Colors.black)
                      ],
                    ),
                    itemCount: 8,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
