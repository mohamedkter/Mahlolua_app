import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: IconButton(
          onPressed: () {},
          icon: CircleAvatar(
            radius: 17,
            child: Icon(
              Icons.more_horiz,
            ),
            backgroundColor: Colors.grey.shade200,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Text(
            'اشعارات',
            style: TextStyle(
              fontFamily: 'cairo',
              fontSize: 21.0,
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_forward,
              ))
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView.separated(
            itemBuilder: (context, index) => CustomNotificationItem(
              title: '!تم الدفع بنجاح',
              desc: 'لقد قمت بدفع الخدمه',
              icon: Icon(
                Icons.credit_card,
                color: Colors.white,
              ),
            ),
            itemCount: 10,
            separatorBuilder: (context, index) => Divider(
              color: Colors.white,
            ),
          )),
    );
  }
}

class CustomNotificationItem extends StatelessWidget {
  const CustomNotificationItem({
    super.key,
    required this.title,
    required this.desc,
    required this.icon,
  });
  final String title;
  final String desc;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(11),
          border: Border.all(color: Colors.grey)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                title,
                style: TextStyle(fontFamily: 'cairo', fontSize: 24.0),
              ),
              Text(
                desc,
                style: TextStyle(
                    fontFamily: 'cairo', fontSize: 19.0, color: Colors.grey),
              ),
            ],
          ),
          SizedBox(
            width: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: CircleAvatar(
              radius: 32.0,
              backgroundColor: Colors.deepPurple,
              child: icon,
            ),
          )
        ],
      ),
    );
  }
}
