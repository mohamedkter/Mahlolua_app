import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Pages/General_Pages/error_page.dart';
import 'package:mahloula/Pages/Loading_Pages/generel_loading_page.dart';
import 'package:mahloula/Pages/Service_Provider_Pages/service_provider_notifications.dart';
import 'package:mahloula/Services/Data/cache_data.dart';
import 'package:mahloula/Services/State_Managment/Service%20_Provider_Cubit/ServiceProviderHomePage_Cubit/serviceprovider_homepage_cubit.dart';
import 'package:mahloula/Services/State_Managment/Service%20_Provider_Cubit/ServiceProviderHomePage_Cubit/serviceprovider_homepage_states.dart';
import 'package:mahloula/Widgets/order_card.dart';
import '../../models/reservation_model.dart';

class ServiceProviderHomePage extends StatefulWidget {
  const ServiceProviderHomePage({super.key});

  @override
  State<ServiceProviderHomePage> createState() =>
      _ServiceProviderHomePageState();
}

class _ServiceProviderHomePageState extends State<ServiceProviderHomePage> {
  bool _isSwitched =
      CacheData.getData(key: "employee_status") == "available" ? true : false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ServiceProviderHomePageCubit>(context).getWaitingOrders();
  }

  @override
  Widget build(BuildContext context) {
    final widthOfScreen = MediaQuery.sizeOf(context).width;
    return Scaffold(body: BlocBuilder<ServiceProviderHomePageCubit,
        ServiceProviderHomePageStates>(
      builder: (context, state) {
        if (state is ServiceProviderHomePageLoading) {
          return GenerelLoadingPage();
        } else if (state is ServiceProviderHomePageSuccess) {
          int countOfOrders =
              BlocProvider.of<ServiceProviderHomePageCubit>(context)
                  .countOfOrders;
          List<Reservation> orders =
              BlocProvider.of<ServiceProviderHomePageCubit>(context)
                  .waitingOrders;
          return SingleChildScrollView(
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
                                     BlocProvider.of<ServiceProviderHomePageCubit>(context).changeServiceProviderState( CacheData.getData(key:"employee_status")=="available"?"busy":"available");
                                    setState(() {
                                    _isSwitched =CacheData.getData(key:"employee_status") == "available" ? true : false;
                                    });
                                  },
                                  activeColor: Colors.green,
                                  inactiveThumbColor: Colors.red,
                                  inactiveTrackColor: Colors.white,
                                  activeTrackColor: Colors.white,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  "متاح",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'cairo',
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        NotificationSettingsScreen()));
                              },
                              icon:
                                  const Icon(Icons.notifications_none_rounded),
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
                                    TimeOfDay.now().hour < 12
                                        ? 'صباح الخير'
                                        : 'مساء الخير',
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
                                      BlocProvider.of<ServiceProviderHomePageCubit>(context).average_rating??"0.0",
                                      style: const TextStyle(
                                          fontFamily: "Cairo",
                                          fontSize: 15,
                                          color: Colors.grey),
                                    ),
                                    const Icon(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                         Text(
                                          "${BlocProvider.of<ServiceProviderHomePageCubit>(context).total_rates}",
                                          style: const TextStyle(
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
                                    image: NetworkImage(
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
                      color: order.status == 'accepted'
                          ? Colors.green
                          : Colors.red,
                      order: order,
                    );
                  },
                  itemCount: orders.length,
                ),
              ],
            ),
          );
        } else {
          return ErrorPage(
            imageParh: "",
            lowerMessage: "",
            upperMessage: "",
          );
        }
      },
    ));
  }
}
