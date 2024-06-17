import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Pages/User_Pages/add_discount_page.dart';
import 'package:mahloula/Widgets/custom_bottom_appbar.dart';
import 'package:mahloula/Pages/User_Pages/get_location_page.dart';


class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final List<String> Houres = ["09:00", "10:00", "11:00", "12:00", "01:00"];
  late int Selected_Houres = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            "تفاصيل الحجز",
            style: TextStyle(
              fontFamily: 'cairo',
              fontSize: 27.0,
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_forward,
                size: 30,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                "اختر التاريخ",
                style: TextStyle(
                    fontFamily: "Cairo",
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: CalendarDatePicker(
                    initialDate: DateTime(2020),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2040),
                    onDateChanged: (value) {}),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                "اختر وقت المعاينه",
                style: TextStyle(
                  fontFamily: "Cairo",
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ChipsChoice.single(
                      choiceCheckmark: true,
                      choiceStyle: C2ChipStyle.filled(
                          selectedStyle: const C2ChipStyle(
                            backgroundColor: MainColor,
                          ),
                          // Border width for the filled chip
                          color: SecondaryColor,
                          height: 40,
                          borderRadius: BorderRadius.circular(20),
                          borderWidth: 3,
                          padding: EdgeInsets.symmetric(horizontal: 20)),
                      value: Selected_Houres,
                      onChanged: (value) {
                        setState(() {
                          Selected_Houres = value;
                        });
                      },
                      choiceItems: C2Choice.listFrom(
                          source: Houres, value: (i, v) => i, label: (i, v) => v),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "كود الخصم",
                style: TextStyle(
                  fontFamily: "Cairo",
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddDiscountPage()));
                      },
                      icon: const Icon(
                        Icons.add,
                        color: MainColor,
                      ),
                      style: ElevatedButton.styleFrom(
                          alignment: Alignment.center,
                          backgroundColor: Color(0xfff1E7ff),
                          minimumSize: Size(45, 45),
                          fixedSize: const Size(45, 45),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0)))),
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    width: 290,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color(0xfff1E7ff),
                        borderRadius: BorderRadius.circular(12)),
                    child:  Directionality(
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
                      hintText:  "ادخل كود الخضم",
                      focusedBorder: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none),
                      border: InputBorder.none,
                      fillColor: Color(0xfff1E7ff),
                      filled: true,
                     
                    ),
                  ),
                ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomAppBar(
        buttonText: "100\$  -الحجز ",
        buttonFunction: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const GetLocationPage()));
        },
      ),
    );
  }
}
