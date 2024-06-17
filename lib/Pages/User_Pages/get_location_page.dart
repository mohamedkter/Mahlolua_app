import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mahloula/Widgets/custom_bottom_appbar.dart';

class GetLocationPage extends StatelessWidget {
  const GetLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: IconButton(
          onPressed: () {},
          icon: CircleAvatar(
            radius: 17,
            backgroundColor: Colors.grey.shade200,
            child: const Icon(
              Icons.more_horiz,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          const Text(
            "العنوان / الموقع",
            style: TextStyle(
              fontFamily: 'cairo',
              fontSize: 27.0,
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_forward,
                size: 30,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height / 2,
              ),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 70,
                child: const Text(
                  "تفاصيل الموقع",
                  style: TextStyle(
                      fontFamily: 'cairo',
                      fontSize: 27.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Divider(
                thickness: 0.4,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "العنوان",
                style: TextStyle(
                    fontFamily: 'cairo',
                    fontSize: 19.0,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 15,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  style: TextStyle(
                    fontFamily: "Cairo",
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      fontFamily: "Cairo",
                      fontSize: 18,
                      color: const Color.fromARGB(255, 118, 115, 115),
                    ),
                    hintText: "ميدان الازهر , اسيوط",
                    focusedBorder: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none),
                    border: InputBorder.none,
                    fillColor: Color(0xfff1E7ff),
                    filled: true,
                    suffixIcon: Icon(
                      Icons.location_on_outlined,
                      color: Color(0xff31589B),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomAppBar(
        buttonText: "تاكيد الحجز - \$100 ",
        buttonFunction: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => GetLocationPage()));
        },
      ),
    );
  }
}
