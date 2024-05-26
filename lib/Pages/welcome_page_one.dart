import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:mahloula/Pages/identify_page.dart';
import 'package:mahloula/Pages/welcome_page_two.dart';

class WelcomePageOne extends StatefulWidget {
  const WelcomePageOne({super.key});

  @override
  State<WelcomePageOne> createState() => _WelcomePageOneState();
}

class _WelcomePageOneState extends State<WelcomePageOne> {
  PageController _pageController = PageController();
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentPageIndex = index;
                });
              },
              children: [
                _buildPage(" نحن نقدم خدمه مثالية \n        باسعار بسيطه"),
                _buildPage("افضل النتائج ورضاكم هو\n        اولويتنا القصوى"),
                _buildPage("هيا نصنع تغيرات رهيبه\n           فى منزلك"),
              ],
            ),
          ),
          DotsIndicator(
            dotsCount: 3,
            position: currentPageIndex,
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
              onTap: () {
                // انتقل إلى الصفحة التالية
                if (currentPageIndex == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const IdentifyPage()),
                  );
                } else {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: Container(
                height: 60,
                width: 350, // استخدام كل المساحة الأفقية المتاحة
                padding: EdgeInsets.all(10.0),
                margin:EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 20, 120, 226), // لون الخلفية
                  borderRadius: BorderRadius.circular(30.0), // زوايا مستديرة
                ),
                child: Center(
                  child: Text(
                    'التالى',
                    style: TextStyle(
                      fontSize: 24.0, // حجم النص
                      color: Colors.white, // لون النص
                    ),
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }

  Widget _buildPage(String text) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/photo/img.png'),
          Text(
            text,
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 35,fontWeight: FontWeight.w600,fontFamily: 'cairo'),
          ),
        ],
      ),
    );
  }
}