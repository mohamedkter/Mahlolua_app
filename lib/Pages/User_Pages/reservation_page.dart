import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Models/service_provider_model.dart';
import 'package:mahloula/Models/voucher_model.dart';
import 'package:mahloula/Pages/User_Pages/add_discount_page.dart';
import 'package:mahloula/Pages/User_Pages/get_order_description.dart';
import 'package:mahloula/Widgets/custom_bottom_appbar.dart';
import 'package:mahloula/Pages/User_Pages/get_location_page.dart';

import '../../Constants/ObjectOrder.dart';
import '../../Models/order_model.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({this.obj, super.key, required this.serviceprovider});
 final ServiceProvider serviceprovider;
  final Order? obj;
  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  TextEditingController _controller = TextEditingController();
  Voucher? selectedVouche;
  TextEditingController addVoucher = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  dynamic vouchers;
  String code = '';

  String DateAndTime = '';
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
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2024),
                      lastDate: DateTime(2040),
                      onDateChanged: (value) {
                        if (value.isAfter(DateTime.now()) &&
                            value.isBefore(
                                DateTime.now().add(Duration(days: 7)))) {
                          String x = value.toString();
                          print(x.substring(0, 10));
                          DateAndTime = x.substring(0, 10) + ' ';
                        } else {
                          setState(() {
                            DateAndTime = '';
                          });
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  backgroundColor: MainColor,
                                  showCloseIcon: true,
                                  content: Column(
                                    children: [
                                      Text(
                                        "هذا التاريخ لا يمكن اختياره ",
                                        style: TextStyle(
                                          fontFamily: "Cairo",
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        "يرجي اختيار موعد في حدود اسبوع من الان",
                                        style: TextStyle(
                                          fontFamily: "Cairo",
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  )));
                        }
                      }),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "اختر وقت المعاينه",
                  style: TextStyle(
                    fontFamily: "Cairo",
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: _controller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'يجب ان تدخل الوقت';
                      }
                    },
                    decoration: InputDecoration(
                      //labelText: 'Select Date and Time',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () => _selectDateTime(context),
                      ),
                    ),
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
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () async {
                          vouchers = await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => AddDiscountPage()));
                          setState(() {
                            if (vouchers != null) {
                              addVoucher.text = vouchers?['code'];
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.add,
                          color: MainColor,
                        ),
                        style: ElevatedButton.styleFrom(
                            alignment: Alignment.center,
                            backgroundColor: const Color(0xfff1E7ff),
                            minimumSize: const Size(45, 45),
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
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          controller: addVoucher,
                          style: TextStyle(
                            fontFamily: "Cairo",
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            enabled: false,
                            hintStyle: TextStyle(
                              fontFamily: "Cairo",
                              fontSize: 18,
                              color: const Color.fromARGB(255, 118, 115, 115),
                            ),
                            hintText: "ادخل كود الخضم",
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
      ),
      bottomNavigationBar: CustomBottomAppBar(
        buttonText:
            "${vouchers == null ? widget.obj?.price : widget.obj!.price! - vouchers["discount"]}\$  الحجز ",
        buttonFunction: () {
          if (key.currentState!.validate() && DateAndTime != '') {
            widget.obj?.dateOfDelivery = DateAndTime;
            if (vouchers != null) {
              code = addVoucher.text;
            }
            if (vouchers!=null) {
                Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    GetOrderDescription(myOrder: widget.obj, serviceProvider: widget.serviceprovider,voucher: Voucher.fromJson(vouchers),)));
            }else{
                Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    GetOrderDescription(myOrder: widget.obj, serviceProvider: widget.serviceprovider,voucher:null,)));
            }
           
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: MainColor,
                showCloseIcon: true,
                content: Column(
                  children: [
                    Text(
                      "هناك مشكلة في موعد المعاينه",
                      style: TextStyle(
                        fontFamily: "Cairo",
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "يرجي اختيار موعد في حدود اسبوع من الان",
                      style: TextStyle(
                        fontFamily: "Cairo",
                        fontSize: 15,
                      ),
                    ),
                  ],
                )));
          }
        },
      ),
    );
  }

  void _selectDateTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      DateTime finalDateTime = DateTime(
        pickedTime.hour,
        pickedTime.minute,
      );

      setState(() {
        String x = pickedTime.toString();
        _controller.text = x.substring(10, 15);
        DateAndTime += _controller.text;
      });
    }
  }
}
