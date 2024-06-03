import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mahloula/Constants/Color_Constants.dart';

class CustomReserveCard extends StatefulWidget {
  const CustomReserveCard({
    super.key,
    required this.color,
    required this.index,
  });

  final Color color;
  final int index;
  @override
  State<CustomReserveCard> createState() => _CustomReserveCardState();
}

class _CustomReserveCardState extends State<CustomReserveCard> {
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
                      Container(
                        width: 65,
                        height: 27,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(7),
                          color: widget.color,
                        ),
                        child: Center(child: checkStatus(widget.index)),
                      )
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
                                height: 15,
                              ),
                              widget.index == 2
                                  ? NextReserveButtons()
                                  : widget.index == 0
                                      ? CompletedAndCanceledReserveButton(
                                          btnFunctoin: () {print("اعادة الحجز");},
                                          btnText: "اعادة الحجز")
                                      : CompletedAndCanceledReserveButton(
                                          btnFunctoin: () {print("عرض الفاتورة الالكترونية");},
                                          btnText: "عرض الفاتورة الالكترونية")
                            ],
                          ),
                        ),
                      ))
                  : const SizedBox(
                      height: 0,
                    ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isTabed = !isTabed;
                  });
                },
                icon: !isTabed
                    ? const Icon(
                        Icons.keyboard_arrow_down,
                        size: 40,
                      )
                    : const Icon(
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

class CompletedAndCanceledReserveButton extends StatelessWidget {
  final VoidCallback btnFunctoin;
  final String btnText;
  const CompletedAndCanceledReserveButton({
    super.key,
    required this.btnFunctoin,
    required this.btnText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: btnFunctoin,
            style: ElevatedButton.styleFrom(
                backgroundColor: MainColor,
                side: BorderSide(color: MainColor),
                elevation: 0,
                fixedSize: Size(320, 25)),
            child: Text(
              btnText,
              style: const TextStyle(
                  fontFamily: "Cairo",
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.w800),
            ))
      ],
    );
  }
}

class NextReserveButtons extends StatelessWidget {
  const NextReserveButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CardButton(
          btn_backgroung: MainColor,
          mainColor: Colors.white,
          btn_text: "عرض الفاتورة ",
          btn_function: () {
            print("عرض الفاتورة ");
          },
        ),
        CardButton(
          btn_backgroung: Colors.white,
          mainColor: MainColor,
          btn_text: " الغاء الحجز",
          btn_function: () {
            print(" الغاء الحجز");
          },
        )
      ],
    );
  }
}

class CardButton extends StatelessWidget {
  final Color btn_backgroung;
  final Color mainColor;
  final String btn_text;
  final VoidCallback btn_function;
  const CardButton({
    super.key,
    required this.btn_backgroung,
    required this.mainColor,
    required this.btn_text,
    required this.btn_function,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: btn_function,
        style: ElevatedButton.styleFrom(
            backgroundColor: btn_backgroung,
            side: BorderSide(color: mainColor),
            elevation: 0,
            fixedSize: Size(165, 25)),
        child: Text(
          btn_text,
          style: TextStyle(
              fontFamily: "Cairo",
              fontSize: 13,
              color: mainColor,
              fontWeight: FontWeight.w800),
        ));
  }
}

Text checkStatus(int ind) {
  if (ind == 0) {
    return const Text(
      'ملغي',
      style: TextStyle(color: Colors.white, fontFamily: 'cairo', fontSize: 13),
    );
  } else if (ind == 1) {
    return const Text(
      'مكتمل',
      style: TextStyle(color: Colors.white, fontFamily: 'cairo', fontSize: 13),
    );
  } else {
    return  const Text(
      'قادم',
      style: TextStyle(color: Colors.white, fontFamily: 'cairo', fontSize: 13),
    );
  }
}
