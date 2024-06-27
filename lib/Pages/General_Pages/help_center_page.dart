import 'package:flutter/material.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Pages/General_Pages/help_center1_page.dart';

class HelpCenterPage extends StatefulWidget {
  @override
  _HelpCenterPageState createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  "مركز المساعدة",
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                     image: DecorationImage(image:AssetImage("assets/photo/logo.png"),),
                    color: MainColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 30,
                  height: 30,
                ),
              ],
            ),
          ),
          bottom: TabBar(
            
            indicatorColor: MainColor,
            indicatorSize: TabBarIndicatorSize.tab, // زيادة عرض الـ indicator
            indicatorWeight: 3.0,
            labelStyle: TextStyle(
              fontSize: 19.0,
              fontFamily: 'cairo',
              color: MainColor,
              fontWeight: FontWeight.bold),
              // زيادة طول الخط
            tabs: [
              Tab(
                child: Text(
                  "تواصل معنا",
                  style: TextStyle(
                    color: MainColor,
                    fontFamily: 'Cairo',
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    height: 1.47,
                    letterSpacing: -0.40799999237060547,
                  ),
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,  // تغيير محاذاة النص
                ),
              ),
              Tab(
                child: Text(
                  "أسئلة شائعة",
                  style: TextStyle(
                    color: const Color(0xFF32589C),
                    fontFamily: 'Cairo',
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    height: 1.47,
                    letterSpacing: -0.40799999237060547,
                  ),
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,  // تغيير محاذاة النص
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            
            ContactUsTab(),
            HelpCenterPage1(), // مباشرة إلى الصفحة الثانية بدون تعيين تبويبات جديدة
          ],
        ),
      ),
    );
  }
}

class ContactUsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          HelpCenterBox(text: "خدمة العملاء"),
          HelpCenterBox(text: "واتساب"),
          HelpCenterBox(text: "موقع الويب"),
          HelpCenterBox(text: "فيسبوك"),
          HelpCenterBox(text: "تطبيق X"),
          HelpCenterBox(text: "انستجرام"),
        ],
      ),
    );
  }
}

class HelpCenterBox extends StatelessWidget {
  final String text;

  const HelpCenterBox({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.5),
      child: Container(
        width: 449,
        height: 66,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 50.0),
          child: Row(
            
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                text,
                textAlign: TextAlign.right, // تحديد محاذاة النص
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  height: 1.47,
                  letterSpacing: -0.40799999237060547,
                  color: Colors.black,
                ),
                textDirection: TextDirection.rtl, // تغيير محاذاة النص هنا
              ),
            ],
          ),
        ),
      ),
    );
  }
}




