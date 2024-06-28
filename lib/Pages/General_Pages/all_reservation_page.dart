import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; // For date parsing and comparison
import 'package:mahloula/Pages/General_Pages/not_found_page.dart';
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
    _tabController.index = 2;
    BlocProvider.of<AllReservitionPageCubit>(context)
        .getAllReservationForUser(CacheData.getData(key: "userId"));
  }

  List<List<Reservation>> filterReservations(List<Reservation> reservations) {
    List<Reservation> upcomingList = [];
    List<Reservation> rejectedList = [];
    List<Reservation> completedList = [];

    for (var reservation in reservations) {
      switch (reservation.status) {
        case 'waiting':
          upcomingList.add(reservation);
          break;
        case 'accepted':
          upcomingList.add(reservation);
          break;
        case 'completed':
          completedList.add(reservation);
          break;
        case 'rejected':
          rejectedList.add(reservation);
          break;
      }
    }
    return [upcomingList, completedList, rejectedList];
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
                          image: const DecorationImage(
                            image: AssetImage("assets/photo/logo.png"),
                          ),
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
            List<List<Reservation>> AllReservation = filterReservations(
                BlocProvider.of<AllReservitionPageCubit>(context).data);
            return TabBarView(
              controller: _tabController,
              children: [
                buildReservationList('ملغي', Colors.red, AllReservation[2]),
                buildReservationList('مكتمل', Colors.green, AllReservation[1]),
                buildReservationList('قادم', Colors.orange, AllReservation[0]),
              ],
            );
          } else {
            return const NotFoundPage(Message: "هناك خطا ما",);
          }
        }));
  }

  Widget buildReservationList(
      String status, Color color, List<Reservation> reservations) {
    return reservations.isEmpty
        ? const NotFoundPage(Message: "لا يوجد حجوزات من هذا النوع",)
        : ListView.builder(
            itemBuilder: (context, index) {
              return CustomReserveCard(
                index: _tabController.index,
                color: color,
                reservation: reservations[index],
              );
            },
            itemCount: reservations.length);
  }
}
