import 'package:flutter/material.dart';
import 'package:mahloula/Pages/User_Pages/login_page.dart';
import 'package:mahloula/Services/Data/cache_data.dart';

class LogoutBottomSheet extends StatelessWidget {
  const LogoutBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "تسجيل خروج",
            style: TextStyle(fontFamily: 'cairo', fontSize: 21.0,color: Colors.red,fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "هل انت متاكد من تسجيل الخروج؟ ",
            style: TextStyle(fontFamily: 'cairo', fontSize: 18.0,color: Colors.black,fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  CacheData.clearCache();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()),(Route<dynamic> route) => false,);
                },
                child: Container(
                  width: 170,
                  height: 55,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(27.0),
                      border: Border.all(color: Colors.blue.shade900)),
                  alignment: Alignment.center,
                  child: Text(
                    'تسجيل خروج',
                    style: TextStyle(fontFamily: 'cairo', color: Colors.white),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  width: 170,
                  height: 55,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(27.0),
                      border: Border.all(color: Colors.blue.shade900)),
                  alignment: Alignment.center,
                  child: Text(
                    'الغاء',
                    style: TextStyle(
                        fontFamily: 'cairo', color: Colors.blue.shade900),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
