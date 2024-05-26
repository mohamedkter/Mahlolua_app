import 'package:flutter/material.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Pages/User_Pages/home_page.dart';
import '../../Widgets/custom_reserve_card.dart';

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
    _tabController =
        TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:
          const Text(
            'الحجوزات',
            style: TextStyle(
                fontSize: 27.0,
                fontFamily: 'cairo',
                color: Colors.black,
                fontWeight: FontWeight.bold),
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
      body: Container(
        child: TabBarView(
          controller: _tabController,
          children: [
            ListView.builder(
              itemBuilder: (context,index) => CustomReserveCard(index: _tabController.index,color: Colors.red,),
              itemCount: 5,
            ),
            ListView.builder(
              itemBuilder: (context,index) => CustomReserveCard(index: _tabController.index,color: Colors.green),
              itemCount: 5,
            ),
            ListView.builder(
              itemBuilder: (context,index) => CustomReserveCard(index: _tabController.index,color: Colors.orange),
              itemCount: 5,
            ),
          ],
        ),
      ),
    );
  }
}
