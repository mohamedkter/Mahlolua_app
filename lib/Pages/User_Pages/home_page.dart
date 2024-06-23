import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Pages/Loading_Pages/card_loading_page.dart';
import 'package:mahloula/Pages/Loading_Pages/original_loading_page.dart';
import 'package:mahloula/Pages/all_reservation_page.dart';
import 'package:mahloula/Pages/User_Pages/original_page.dart';
import 'package:mahloula/Pages/User_Pages/user_profile_page.dart';
import 'package:mahloula/Pages/all_reservation_page.dart';
import 'package:mahloula/Pages/error_page.dart';
import 'package:mahloula/Services/State_Managment/User_Cubit/Home_Page_Cubit/home_page_cubit.dart';
import 'package:mahloula/Services/State_Managment/User_Cubit/Home_Page_Cubit/home_page_status.dart';

class HomePage extends StatefulWidget {
  HomePage({required this.name});
  final String name;

  @override
  State<HomePage> createState() => _HomePageState();
}

gettoken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  print("================================================");
  print(token);
  print("================================================");
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    gettoken();
   BlocProvider.of<HomePageCubit>(context).getPageContent();
  }

  int index = 2;
  Map<int, Widget> Screens = {
    1: AllReservationPage(),
    0: UserProfilePage(),
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<HomePageCubit, HomePageStatus>(
        builder: (context, state) {
            Widget bodyWidget;
    if (state is LoadingStatus) {
      bodyWidget = const OriginalLoadingPage();
    } else if (state is SuccessStatus) {
      bodyWidget = (index == 2 ? OriginalPage(name: widget.name,services: BlocProvider.of<HomePageCubit>(context).services,) : Screens[index])!;
    } else {
      bodyWidget = ErrorPage(upperMessage: "خطا في الانترنت", lowerMessage: "اقفل و افتح تاني ");
    }
    return bodyWidget;
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        iconSize: 27,
        unselectedLabelStyle:
            const TextStyle(fontSize: 12, fontFamily: 'cairo'),
        selectedLabelStyle: const TextStyle(fontSize: 14, fontFamily: 'cairo'),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: MainColor,
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
