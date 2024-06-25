import 'package:flutter/material.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Models/employee_orders_model.dart';
import 'package:mahloula/Pages/Loading_Pages/generel_loading_page.dart';
import 'package:mahloula/Pages/Service_Provider_Pages/service_provider_notifications.dart';
import 'package:mahloula/Pages/notifications_page.dart';
import 'package:mahloula/Services/Api/get_methods.dart';
import 'package:mahloula/Services/Data/cache_data.dart';
import 'package:mahloula/Widgets/order_card.dart';
import '../../models/reservation_model.dart';

class ServiceProviderHomePage extends StatefulWidget {
  const ServiceProviderHomePage({super.key});

  @override
  State<ServiceProviderHomePage> createState() =>
      _ServiceProviderHomePageState();
}

class _ServiceProviderHomePageState extends State<ServiceProviderHomePage> {
  bool _isSwitched = false;
  bool isLoad = true;
  late int countOfOrders;
  List<EmployeeOrder> orders = [];

  @override
  void initState() {
    super.initState();
    getCounterOfOrder();
    getOrders();
  }

  Future<void> getCounterOfOrder() async {
    final employeeId = CacheData.getData(key: "employee_id");
    countOfOrders = await GetMethods.getCountOrders(employeeId);
    setState(() {
      isLoad = false;
    });
  }

  Future<void> getOrders() async {
    final employeeId = CacheData.getData(key: "employee_id");
    List<EmployeeOrder> fetchedOrders = await GetMethods.getEmployeeOrders(employeeId);
    setState(() {
      orders = fetchedOrders;
    });
  }

  @override
  Widget build(BuildContext context) {
    final widthOfScreen = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: isLoad
          ? GenerelLoadingPage()
          : SingleChildScrollView(
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
                          padding: const EdgeInsets.only(top: 70, left: 15, right: 15),
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
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationSettingsScreen()));
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
                              decoration: BoxDecoration(
                                  border: Border.all(color: MainColor),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              width: widthOfScreen / 1.3,
                              height: 200,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 60),
                                    child: Text(
                                      TimeOfDay.now().hour < 12 ? 'صباح الخير' : 'مساء الخير',
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontFamily: 'cairo',
                                          fontSize: 16),
                                    ),
                                  ),
                                  Text(
                                    "${CacheData.getData(key: "name")}",
                                    style: const TextStyle(
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
                                  const Divider(
                                    indent: 40,
                                    endIndent: 40,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          const Text(
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
                                            "$countOfOrders",
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
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return OrderCard(
                        color: order.status == 'accepted' ? Colors.green : Colors.red,
                        order: order,  
                      );
                    },
                    itemCount: orders.length,
                  ),
                ],
              ),
            ),
    );
  }
}
