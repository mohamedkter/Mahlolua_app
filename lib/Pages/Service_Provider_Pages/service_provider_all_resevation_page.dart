import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; // For date parsing and comparison
import 'package:mahloula/Pages/General_Pages/not_found_page.dart';
import 'package:mahloula/Pages/Loading_Pages/generel_loading_page.dart';
import 'package:mahloula/Pages/User_Pages/check_page.dart';
import 'package:mahloula/Pages/User_Pages/specific_service_page.dart';
import 'package:mahloula/Services/State_Managment/Alll_Reservation_Page_Cubit/all_reserviation_page_cubit.dart';
import 'package:mahloula/Services/State_Managment/Alll_Reservation_Page_Cubit/all_reserviation_page_status.dart';
import 'package:mahloula/Widgets/order_card.dart';
import '../../Constants/Color_Constants.dart';
import '../../Widgets/custom_reserve_card.dart';
import '../../Models/reservation_model.dart';
import '../../Services/Api/get_methods.dart';
import '../../Services/Data/cache_data.dart';

class ServiceProviderAllReservationPage extends StatefulWidget {
  ServiceProviderAllReservationPage({Key? key}) : super(key: key);

  @override
  State<ServiceProviderAllReservationPage> createState() =>
      _AllReservationPageState();
}

class _AllReservationPageState extends State<ServiceProviderAllReservationPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.index = 2;
    BlocProvider.of<AllReservitionPageCubit>(context)
        .getAllReservationForServiceProvider();
  }

  List<List<Reservation>> filterReservations(List<Reservation> reservations) {
    List<Reservation> waitingList = [];
    List<Reservation> acceptedList = [];
    List<Reservation> completedList = [];

    for (var reservation in reservations) {
      switch (reservation.status) {
        case 'waiting':
          waitingList.add(reservation);
          break;
        case 'accepted':
          acceptedList.add(reservation);
          break;
        case 'completed':
          completedList.add(reservation);
          break;
      }
    }
    return [waitingList, acceptedList, completedList];
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
                          image: DecorationImage(
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
            labelStyle: const TextStyle(
                fontSize: 19.0,
                fontFamily: 'cairo',
                color: MainColor,
                fontWeight: FontWeight.bold),
            tabs: const [
              Tab(text: 'مكتمل'),
              Tab(text: 'انتظار'),
              Tab(text: 'قادم'),
            ],
          ),
        ),
        body: BlocBuilder<AllReservitionPageCubit, AllReservationPageStatus>(
            builder: (context, state) {
          if (state is AllReservationPageLoadingStatus) {
            return const GenerelLoadingPage();
          } else if (state is AllReservationPageSuccessStatus) {
            List<List<Reservation>> filteredReservations = filterReservations(
                BlocProvider.of<AllReservitionPageCubit>(context)
                    .employeeOrders);
            return TabBarView(
              controller: _tabController,
              children: [
                buildReservationList(
                  'مكتمل',
                  Colors.red,
                  filteredReservations[2],
                ),
                buildReservationList(
                  'انتظار',
                  Colors.green,
                  filteredReservations[0],
                ),
                buildReservationList(
                    'قادم', Colors.orange, filteredReservations[1]),
              ],
            );
          } else {
            return const NotFoundPage(
              Message: "يوجد خطا ما ",
            );
          }
        }));
  }

  Widget buildReservationList(
      String status, Color color, List<Reservation> reservation) {
    return reservation.length != 0
        ? ListView.builder(
            itemBuilder: (context, index) {
              return OrderCard(
                color: color,
                order: reservation[index],
                acceptedFunctoin: () {
                  BlocProvider.of<AllReservitionPageCubit>(context)
                      .changeOrderStatusForServiceProvider(
                          int.parse(reservation[index].id), "accepted");
                },
                rejectedFunctoin: () {
                  BlocProvider.of<AllReservitionPageCubit>(context)
                      .changeOrderStatusForServiceProvider(
                          int.parse(reservation[index].id), "rejected");
                },
              );
            },
            itemCount: reservation.length,
          )
        : NotFoundPage(Message: "لا يوجد حجوزات من هذا النوع");
  }
}

class CompletedAndCanceledReserveButton extends StatelessWidget {
  final VoidCallback btnFunctoin;
  final String btnText;
  const CompletedAndCanceledReserveButton({
    Key? key,
    required this.btnFunctoin,
    required this.btnText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: btnFunctoin,
          style: ElevatedButton.styleFrom(
            backgroundColor: MainColor,
            side: const BorderSide(color: MainColor),
            elevation: 0,
            fixedSize: const Size(320, 25),
          ),
          child: Text(
            btnText,
            style: const TextStyle(
              fontFamily: "Cairo",
              fontSize: 13,
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

class NextReserveButtons extends StatefulWidget {
  final Reservation reservation;
  const NextReserveButtons({
    Key? key,
    required this.reservation,
  }) : super(key: key);

  @override
  State<NextReserveButtons> createState() => _NextReserveButtonsState();
}

class _NextReserveButtonsState extends State<NextReserveButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CardButton(
          btn_backgroung: MainColor,
          mainColor: Colors.white,
          btn_text: "عرض الفاتورة ",
          btn_function: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CheckPage(reservation: widget.reservation)),
            );
          },
        ),
        CardButton(
          btn_backgroung: Colors.white,
          mainColor: MainColor,
          btn_text: " الغاء الحجز",
          btn_function: () {
            BlocProvider.of<AllReservitionPageCubit>(context)
                .changeOrderStatusForUser(
                    CacheData.getData(key: "userId"), "rejected");
          },
        ),
      ],
    );
  }
}

class CardButton extends StatelessWidget {
  final Color btn_backgroung;
  final Color mainColor;
  final String btn_text;
  final VoidCallback btn_function;
  const CardButton({
    Key? key,
    required this.btn_backgroung,
    required this.mainColor,
    required this.btn_text,
    required this.btn_function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: btn_function,
      style: ElevatedButton.styleFrom(
        backgroundColor: btn_backgroung,
        side: BorderSide(color: mainColor),
        elevation: 0,
        fixedSize: const Size(155, 25),
      ),
      child: Text(
        btn_text,
        style: TextStyle(
          fontFamily: "Cairo",
          fontSize: 13,
          color: mainColor,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

Text checkStatus(int ind) {
  if (ind == 0) {
    return const Text(
      'ملغي',
      style: TextStyle(color: Colors.white, fontFamily: 'cairo', fontSize: 13),
    );
  } else if (ind == 1) {
    return const Text(
      'مكتمل',
      style: TextStyle(color: Colors.white, fontFamily: 'cairo', fontSize: 13),
    );
  } else {
    return const Text(
      'قادم',
      style: TextStyle(color: Colors.white, fontFamily: 'cairo', fontSize: 13),
    );
  }
}
