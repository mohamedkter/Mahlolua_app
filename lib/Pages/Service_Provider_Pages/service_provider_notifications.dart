import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:mahloula/Models/employee_notification_model.dart';
import '../../Constants/Color_Constants.dart';
import '../../Services/Data/cache_data.dart';
import 'package:mahloula/Services/Api/get_methods.dart';

class NotificationSettingsScreen extends StatefulWidget {
  @override
  _NotificationSettingsScreenState createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  late Future<List<EmployeeNotification>> futureNotifications;

  @override
  void initState() {
    super.initState();
    final employeeId = CacheData.getData(key: "employee_id");
    futureNotifications = GetMethods.getEmployeeNotifications(
        employeeId); // Replace with actual employeeId
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  const Text(
                    "الاشعارات",
                    style: TextStyle(
                      fontFamily: 'cairo',
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    decoration: BoxDecoration(
                      image: const DecorationImage(
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
            ],
          ),
        ),
      ),
      body: FutureBuilder<List<EmployeeNotification>>(
        future: futureNotifications,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No notifications available'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final notification = snapshot.data![index];
                  return Card(
                    color: Colors.white,
                    elevation: 0,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.notifications,
                                color: MainColor,
                              ),
                              Expanded(
                                child: Text(
                                  'رقم الاوردر: ${notification.orderId}',
                                  style: TextStyle(
                                    fontFamily: "Cairo",
                                    fontSize: 17,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Text(
                                  'التوقيت: ${notification.timestamp}',
                                  style: TextStyle(
                                    fontFamily: "Cairo",
                                    fontSize: 17,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Text(
                                  ' يرجى متابعة الملف الشخصى لرؤية تفاصيل الاوردر كاملة...',
                                  style: TextStyle(
                                    fontFamily: "Cairo",
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
