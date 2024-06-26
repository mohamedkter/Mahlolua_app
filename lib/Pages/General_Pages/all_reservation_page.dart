import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; // For date parsing and comparison
import 'package:mahloula/Pages/Loading_Pages/generel_loading_page.dart';
import 'package:mahloula/Pages/User_Pages/specific_service_page.dart';
import 'package:mahloula/Services/State_Managment/Alll_Reservation_Page_Cubit/all_reserviation_page_cubit.dart';
import 'package:mahloula/Services/State_Managment/Alll_Reservation_Page_Cubit/all_reserviation_page_status.dart';
import '../../../Constants/Color_Constants.dart';
import '../../../Widgets/custom_reserve_card.dart';
import '../../../models/reservation_model.dart';
import '../../../Services/Api/get_methods.dart';
import '../../../Services/Data/cache_data.dart';

class AllReservationPage extends StatefulWidget {
  AllReservationPage({Key? key}) : super(key: key);

  @override
  State<AllReservationPage> createState() => _AllReservationPageState();
}

class _AllReservationPageState extends State<AllReservationPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.index=2;
    BlocProvider.of<AllReservitionPageCubit>(context)
        .getAllReservationForUser(CacheData.getData(key: "userId"));
  }

  List<Reservation> filterReservations(String status, List<Reservation> res) {
    return res.where((reservation) {
      final currentTime = DateTime.now();
      final reservationDateTime = DateTime.parse(reservation.dateOfDelivery);

      if (status == 'ملغي' && reservation.status == 'rejected') {
        return true;
      } else if (status == 'مكتمل' &&
          reservationDateTime.isBefore(currentTime)) {
        return true;
      } else if (status == 'قادم' &&
          (reservation.status == 'accepted' ||
              reservation.status == 'waiting')) {
        return reservationDateTime.isAfter(currentTime);
      }
      return false;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const Text(
                      " الحجوزات",
                      style: TextStyle(
                          fontFamily: 'cairo',
                          fontSize: 23.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: MainColor,
                          borderRadius: BorderRadius.circular(10)),
                      width: 30,
                      height: 30,
                    )
                  ],
                )
              ],
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: MainColor,
            indicatorWeight: 4,
            controller: _tabController,
            labelStyle: TextStyle(
                fontSize: 19.0,
                fontFamily: 'cairo',
                color: MainColor,
                fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: 'ملغي'),
              Tab(text: 'مكتمل'),
              Tab(text: 'قادم'),
            ],
          ),
        ),
        body: BlocBuilder<AllReservitionPageCubit, AllReservationPageStatus>(
            builder: (context, state) {
          if (state is AllReservationPageLoadingStatus) {
            return GenerelLoadingPage();
          } else if (state is AllReservationPageSuccessStatus) {
            return TabBarView(
              controller: _tabController,
              children: [
                buildReservationList('ملغي', Colors.red),
                buildReservationList('مكتمل', Colors.green),
                buildReservationList('قادم', Colors.orange),
              ],
            );
          } else {
            return const NotFoundPage();
          }
        }));
  }

  Widget buildReservationList(String status, Color color) {
    return ListView.builder(
      itemBuilder: (context, index) {
        var filteredReservations = filterReservations(
            status, BlocProvider.of<AllReservitionPageCubit>(context).data);
        if (index < filteredReservations.length) {
          return CustomReserveCard(
            index: _tabController.index,
            color: color,
            reservation: filteredReservations[index],
          );
        } else {
          return const SizedBox(); // or any other fallback widget
        }
      },
      itemCount: filterReservations(
              status, BlocProvider.of<AllReservitionPageCubit>(context).data)
          .length,
    );
  }
}
