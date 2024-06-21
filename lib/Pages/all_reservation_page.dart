import 'package:flutter/material.dart';
import '../../Constants/Color_Constants.dart';
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
              Padding(
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
