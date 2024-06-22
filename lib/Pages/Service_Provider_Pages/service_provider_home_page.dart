import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Pages/notifications_page.dart';
import 'package:mahloula/Services/Data/cache_data.dart';
import 'package:mahloula/Widgets/order_card.dart';

class ServiceProviderHomePage extends StatefulWidget {
  const ServiceProviderHomePage({super.key});

  @override
  State<ServiceProviderHomePage> createState() =>
      _ServiceProviderHomePageState();
}

class _ServiceProviderHomePageState extends State<ServiceProviderHomePage> {
    bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    final widthOfScreen = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(color: MainColor),
                  width: double.infinity,
                  height: 250,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 70, left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Switch(
                              value: _isSwitched,
                              onChanged: (value) {
                                setState(() {
                                  _isSwitched = value;
                                });
                              },
                              activeColor: Colors.green,
                              inactiveThumbColor: Colors.red,
                              inactiveTrackColor: Colors.white,
                              activeTrackColor: Colors.white,
                            ),
                            SizedBox(width: 5,),
                            Text("متاح",style: const TextStyle(
                              color: Colors.white,
                fontFamily: 'cairo',
                fontSize: 18.0,
                fontWeight: FontWeight.w500),)
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (constext)=>NotificationsPage()));
                          },
                          icon: const Icon(Icons.notifications_none_rounded),
                          color: Colors.white,
                          iconSize: 35,
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 150),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 60),
                              child: Text(
                                TimeOfDay.now().hour < 12 ? 'صباح الخير' : 'مساء الخير',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'cairo',
                                    fontSize: 16),
                              ),
                            ),
                            Text(
                              "${CacheData.getData(key: "name")}",
                              style: TextStyle(
                                fontFamily: 'cairo',
                                fontSize: 21.0,
                                //fontWeight: FontWeight.bold
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "4.7",
                                  style: TextStyle(
                                      fontFamily: "Cairo",
                                      fontSize: 15,
                                      color: Colors.grey),
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                )
                              ],
                            ),
                            Divider(
                              indent: 40,
                              endIndent: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "22",
                                      style: TextStyle(
                                          color: MainColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "المراجعات",
                                      style: TextStyle(
                                          fontFamily: "Cairo",
                                          fontSize: 15,
                                          color: Colors.grey.shade700),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "72",
                                      style: TextStyle(
                                          color: MainColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "اجمالي الاعمال",
                                      style: TextStyle(
                                          fontFamily: "Cairo",
                                          fontSize: 15,
                                          color: Colors.grey.shade700),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: MainColor),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        width: widthOfScreen / 1.3,
                        height: 200,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(70),
                            image: DecorationImage(
                                image:  NetworkImage(
                                        "$PartImagePath${CacheData.getData(key: "image")}"),
                                fit: BoxFit.cover)),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "احدث الطلبات",
                  style: TextStyle(
                      fontFamily: "Cairo",
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                )
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => OrderCard(
                color: Colors.red,
              ),
              itemCount: 5,
            ),
          ],
        ),
      ),
    );
  }
}
