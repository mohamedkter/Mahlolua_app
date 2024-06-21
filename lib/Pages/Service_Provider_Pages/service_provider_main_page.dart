import 'package:flutter/material.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Pages/Service_Provider_Pages/service_provider_all_resevation_page.dart';
import 'package:mahloula/Pages/Service_Provider_Pages/service_provider_home_page.dart';
import 'package:mahloula/Pages/Service_Provider_Pages/service_provider_profile_page.dart';
import 'package:mahloula/Pages/all_reservation_page.dart';

class ServiceProviderMainPage extends StatefulWidget {
  ServiceProviderMainPage({required this.name});
  final String name;

  @override
  State<ServiceProviderMainPage> createState() => _ServiceProviderMainPageState();
}

class _ServiceProviderMainPageState extends State<ServiceProviderMainPage> {
  int index = 2;
  Map<int,Widget> Screens = {
    1 : AllReservationPage(),
    0 : ServiceProviderProfilePage(),
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: index == 2 ? ServiceProviderHomePage() : Screens[index],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        iconSize: 27,
        unselectedLabelStyle:
            const TextStyle(fontSize: 12, fontFamily: 'cairo'),
        selectedLabelStyle: const TextStyle(fontSize: 14, fontFamily: 'cairo'),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedItemColor:MainColor,
        onTap: (ind) {
          setState(() {
            index = ind;
          });
        },
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_outlined,
            ),
            label: 'ملفك',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_month,
            ),
            label: 'الحجوزات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'الرئيسية',
          ),
        ],
      ),
    );
  }
}






