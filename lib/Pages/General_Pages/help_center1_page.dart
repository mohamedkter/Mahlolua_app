import 'package:flutter/material.dart';

class HelpCenterPage1 extends StatefulWidget {
  @override
  _HelpCenterPage1State createState() => _HelpCenterPage1State();
}

class _HelpCenterPage1State extends State<HelpCenterPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _buildFaqSection(), // "أسئلة شائعة" tab
    );
  }

  Widget _buildFaqSection() {
    return Padding(
      padding: const EdgeInsets.all(22.0),
      child: ListView(
        children: [
          _buildFaqBox("ايه هو محلولة؟", "تفاصيل عن محلولة تنلةةة "),
          SizedBox(height: 25),
          _buildFaqBox("ازاى استعمل محلولة", "تفاصيل عن استعمال محلولة..."),
          SizedBox(height: 25),
          _buildFaqBox("ازاى الغى حجز؟", "تفاصيل عن إلغاء الحجز..."),
          SizedBox(height: 25),
          _buildFaqBox("هل تطبيق محلولة مجانى؟", "تفاصيل عن تطبيق محلولة..."),
          SizedBox(height: 25),
          _buildFaqBox("كيف انضم الى فريق محلولة؟", "تفاصيل عن الانضمام لفريق محلولة..."),
          SizedBox(height: 25),
          _buildFaqBox("ايه هى طرق الدفع فى محلولة؟", "تفاصيل عن طرق الدفع..."),
          SizedBox(height: 25),
          _buildFaqBox("ايه هى طرق الدفع فى محلولة؟", "تفاصيل عن طرق الدفع..."),
          SizedBox(height: 25),
          _buildFaqBox("ايه هى طرق الدفع فى محلولة؟", "تفاصيل عن طرق الدفع..."),
          SizedBox(height: 25),
          _buildFaqBox("ايه هى طرق الدفع فى محلولة؟", "تفاصيل عن طرق الدفع..."),
          SizedBox(height: 25),
          _buildFaqBox("ايه هى طرق الدفع فى محلولة؟", "تفاصيل عن طرق الدفع..."),
        ],
      ),
    );
  }

  Widget _buildFaqBox(String title, String content) {
    return Container(
      width: 349,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
        color: Colors.white,
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ExpansionTile(
          title: Text(
            title,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 15.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF212121),
            ),
          ),
          collapsedIconColor: Colors.black, // Color when tile is collapsed
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                content,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14.0,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
          trailing: Icon(Icons.keyboard_arrow_down, color: Color(0xFF32589C)), // Customized expansion arrow
        ),
      ),
    );
  }
}
