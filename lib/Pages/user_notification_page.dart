import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:mahloula/Models/user_notification_model.dart'; // استبدال باسم الملف الصحيح
import 'package:mahloula/Services/Api/get_methods.dart';
import '../../Constants/Color_Constants.dart';
import '../../Services/Data/cache_data.dart';

class UserNotificationSettingsScreen extends StatefulWidget {
  @override
  _NotificationSettingsScreenState createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<UserNotificationSettingsScreen> {
  late Future<List<UserNotification>> futureNotifications;

  @override
  void initState() {
    super.initState();
    //final userId = CacheData.getData(key: "user_id");
    futureNotifications =  GetMethods.getUserNotifications(1);
       // استبدال برقم المستخدم الفعلي
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
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: MainColor,
                        borderRadius: BorderRadius.circular(10)),
                    width: 30,
                    height: 30,
                  )
                ],
              )
            ],
          ),
        ),
      ),
      body: FutureBuilder<List<UserNotification>>(
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: Colors.black, width: 0.8),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ExpansionTile(
                      leading: Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 10),
                        child: Icon(Icons.notifications),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              notification.employeename,
                              style: TextStyle(
                                fontFamily: "Cairo",
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          
                        ],
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const SizedBox(height: 5),
                              Text(
                                notification.message,
                                style: TextStyle(
                                  fontFamily: "Cairo",
                                  fontSize: 17,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 5),
                            
                              Text(
                                'التوقيت: ${notification.timestamp}',
                                style: TextStyle(
                                  fontFamily: "Cairo",
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
