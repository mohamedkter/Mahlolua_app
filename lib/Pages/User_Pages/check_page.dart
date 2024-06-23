import 'package:flutter/material.dart';
import '../../models/reservation_model.dart'; // Adjust the import path as per your project structure

class CheckPage extends StatelessWidget {
  final Reservation reservation;

  const CheckPage({Key? key, required this.reservation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الفاتورة '),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildDetailItem('اسم الموظف', reservation.employeeName),
          _buildDetailItem('اسم الخدمة', reservation.serviceName),
          _buildDetailItem('تاريخ التسليم', reservation.dateOfDelivery),
          _buildDetailItem('الموقع', reservation.location),
          _buildDetailItem('السعر', reservation.location)
        ],
      ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }
}