import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mahloula/Constants/Color_Constants.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({
    super.key,
    required this.color,
  });

  final Color color;
  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool isTabed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Card(
        color: Colors.white38,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: Colors.black, width: 0.8)),
        child: Padding(
          padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 10),
                    child: Icon(Icons.maps_home_work_outlined),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "محمد محمود",
                        style: TextStyle(
                            fontFamily: "Cairo",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "صيانه تكيف",
                        style: TextStyle(
                            fontFamily: "Cairo",
                            fontSize: 15,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "2024-12-12",
                        style: TextStyle(
                            fontFamily: "Cairo",
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                        color: MainColor,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                  ),
                ],
              ),
              const Divider(
                endIndent: 10,
                indent: 10,
              ),
              isTabed
                  ? Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 3,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "الوقت والتاريخ",
                                    style: TextStyle(
                                        fontFamily: "Cairo",
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "12-12-2024 | 10:3 - 10:00 ص",
                                    style: TextStyle(
                                        fontFamily: "Cairo",
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "الموقع",
                                    style: TextStyle(
                                        fontFamily: "Cairo",
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    " النزله - اسيوط",
                                    style: TextStyle(
                                        fontFamily: "Cairo",
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "الوصف :",
                                    style: TextStyle(
                                        fontFamily: "Cairo",
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "عندي مشكله في صرف المطبخ سبب شكلالمشكله دى تقريبا الحوض وفيه تسريب في الحماممن فتره",
                                      style: TextStyle(
                                          fontFamily: "Cairo",
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                      maxLines: 3,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  OredrCardButton(
                                    btn_backgroung: MainColor,
                                    mainColor: Colors.white,
                                    btn_text: "قبول الطلب",
                                    btn_function: (){print("Accept");},
                                  ),
                                  OredrCardButton(
                                    btn_backgroung: Colors.white,
                                    mainColor: MainColor,
                                    btn_text: "رفض الطلب",
                                    btn_function: (){print("Not Accept");},
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ))
                  : SizedBox(
                      height: 0,
                    ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isTabed = !isTabed;
                  });
                },
                icon: !isTabed
                    ? Icon(
                        Icons.keyboard_arrow_down,
                        size: 40,
                      )
                    : Icon(
                        Icons.keyboard_arrow_up,
                        size: 40,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OredrCardButton extends StatelessWidget {
  final Color btn_backgroung;
  final Color mainColor;
  final String btn_text;
  final VoidCallback btn_function;
  const OredrCardButton({
    super.key,
    required this.btn_backgroung,
    required this.mainColor,
    required this.btn_text, required this.btn_function,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: btn_function,
        style: ElevatedButton.styleFrom(
            backgroundColor: btn_backgroung,
            side: BorderSide(color: mainColor),
            elevation: 0,
            fixedSize: Size(160, 25)),
        child: Text(
          btn_text,
          style: TextStyle(
              fontFamily: "Cairo",
              fontSize: 15,
              color: mainColor,
              fontWeight: FontWeight.w800),
        ));
  }
}
