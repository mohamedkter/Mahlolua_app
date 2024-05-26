import 'package:flutter/material.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Pages/User_Pages/all_reservation_page.dart';
import 'package:mahloula/Pages/User_Pages/my_profile_page.dart';
import 'package:mahloula/Pages/User_Pages/original_page.dart';
import 'package:mahloula/Pages/User_Pages/user_profile_page.dart';


class HomePage extends StatefulWidget {
  HomePage({required this.name});
  final String name;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 2;
  Map<int,Widget> Screens = {
    1 : AllReservationPage(),
    0 : UserProfilePage(),
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: index == 2 ? OriginalPage(name: widget.name == null ? 'No Name' : widget.name!) : Screens[index],
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






