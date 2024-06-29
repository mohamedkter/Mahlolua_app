import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Pages/General_Pages/help_center1_page.dart';
import 'package:url_launcher/url_launcher.dart';

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
                    image: DecorationImage(
                      image: AssetImage("assets/photo/logo.png"),
                    ),
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
                  textAlign: TextAlign.right, // تغيير محاذاة النص
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
                  textAlign: TextAlign.right, // تغيير محاذاة النص
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ContactUsTab(),
            HelpCenterPage1(),
          ],
        ),
      ),
    );
  }
}

class ContactUsTab extends StatelessWidget {
  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
              onTap: () {
                // _launchUrl("");
              },
              child: HelpCenterBox(text: "خدمة العملاء")),
          GestureDetector(
              onTap: () async {
                final Uri smsLaunchUri = Uri(
                  scheme: 'sms',
                  path: '+2011005763000',
                  queryParameters: <String, String>{
                    'body': Uri.encodeComponent('احتاج الي مساعده'),
                  },
                );
                await launchUrl(smsLaunchUri);
              },
              child: HelpCenterBox(text: "واتساب")),
          GestureDetector(
              onTap: () {
                _launchUrl("https://mahllola.online");
              },
              child: HelpCenterBox(text: "موقع الويب")),
          GestureDetector(
              onTap: () {
                _launchUrl(
                    "https://www.facebook.com/profile.php?id=61560792118858");
              },
              child: HelpCenterBox(text: "فيسبوك")),
          GestureDetector(
              onTap: () {
                _launchUrl("https://x.com/Mahloula_2024");
              },
              child: HelpCenterBox(text: "تطبيق X")),
          GestureDetector(
              onTap: () {
                _launchUrl("https://www.instagram.com/mahloula2024/");
              },
              child: HelpCenterBox(text: "انستجرام")),
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
