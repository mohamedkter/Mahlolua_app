import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date parsing and comparison
import '../../Constants/Color_Constants.dart';
import '../../Widgets/custom_reserve_card.dart';
import '../../models/reservation_model.dart';
import '../../Services/Api/get_methods.dart';
import '../../Services/Data/cache_data.dart';

class AllReservationPage extends StatefulWidget {
  AllReservationPage({Key? key}) : super(key: key);

  @override
  State<AllReservationPage> createState() => _AllReservationPageState();
}

class _AllReservationPageState extends State<AllReservationPage> with TickerProviderStateMixin {
  late TabController _tabController;
  List<Reservation> reservations = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    fetchReservations();
  }

  Future<void> fetchReservations() async {
    int userId = CacheData.getData(key: "userId"); // Replace with actual user ID
    List<Reservation> data = await GetMethods.getUserOrders(userId);
    
    // Check if the state is still mounted before calling setState
    if (mounted) {
      setState(() {
        reservations = data;
        isLoading = false;
      });
    }

    // Check if data is being fetched correctly
    print('Fetched reservations: ${reservations.length}');
    for (var reservation in reservations) {
      print('Reservation: ${reservation.id}, ${reservation.employeeName}, ${reservation.location}, ${reservation.serviceName}, ${reservation.dateOfDelivery}');
    }
  }

  List<Reservation> filterReservations(String status) {
    return reservations.where((reservation) {
      final currentTime = DateTime.now();
      final reservationDateTime = DateTime.parse(reservation.dateOfDelivery);

      if (status == 'ملغي' && reservation.status == 'rejected') {
        return true;
      } else if (status == 'مكتمل' && reservationDateTime.isBefore(currentTime)) {
        return true;
      } else if (status == 'قادم' && (reservation.status == 'accepted' || reservation.status == 'waiting')) {
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                buildReservationList('ملغي', Colors.red),
                buildReservationList('مكتمل', Colors.green),
                buildReservationList('قادم', Colors.orange),
              ],
            ),
    );
  }

  Widget buildReservationList(String status, Color color) {
    return ListView.builder(
      itemBuilder: (context, index) {
        var filteredReservations = filterReservations(status);
        if (index < filteredReservations.length) {
          print('Rendering $status reservation: ${filteredReservations[index].id}');
          return CustomReserveCard(
            index: _tabController.index,
            color: color,
            reservation: filteredReservations[index],
          );
        } else {
          return SizedBox(); // or any other fallback widget
        }
      },
      itemCount: filterReservations(status).length,
    );
  }
}
