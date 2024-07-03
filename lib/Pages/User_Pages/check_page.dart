import 'package:flutter/material.dart';
import '../../Models/reservation_model.dart'; // تعديل مسار الاستيراد حسب هيكلة مشروعك

class CheckPage extends StatelessWidget {
  final Reservation reservation;

  const CheckPage({Key? key, required this.reservation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width * 0.05; // تعيين حجم الخط بناءً على عرض الشاشة

    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل الحجز'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildDetailItem('اسم الموظف', reservation.employeeName, fontSize),
                SizedBox(height: 16),
                _buildDetailItem('اسم الخدمة', reservation.serviceName, fontSize),
                SizedBox(height: 16),
                _buildDetailItem('تاريخ التسليم', reservation.dateOfDelivery, fontSize),
                SizedBox(height: 16),
                _buildDetailItem('الموقع', reservation.location.city, fontSize),
                SizedBox(height: 16),
                _buildDetailItem('اسم العميل', reservation.username.toString(), fontSize),
                  SizedBox(height: 16),
                _buildDetailItem('السعر ', reservation.price.toString(), fontSize),
                  SizedBox(height: 16),
                _buildDetailItem('خصم ', reservation.total_discount??"0", fontSize),
                  SizedBox(height: 16),
                _buildDetailItem('السعر بعد الخصم ', reservation.price_after_discount??reservation.price, fontSize), // تفترض أن السعر قيمة رقمية
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, String value, double fontSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: fontSize,
                color: Colors.grey[800],
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
