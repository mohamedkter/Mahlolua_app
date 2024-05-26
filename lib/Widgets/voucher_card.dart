import 'package:flutter/material.dart';

class VoucherCard extends StatefulWidget {
  final Color voucherColor;
  final String voucherText;
  final String voucherDuration;
  VoucherCard(
      {super.key,
      required this.voucherColor,
      required this.voucherText,
      required this.voucherDuration});

  @override
  State<VoucherCard> createState() => _VoucherCardState();
}

class _VoucherCardState extends State<VoucherCard> {
  int? selected = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
          height: 110,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.4),
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20)),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset("assets/photo/voucher.png"),
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.white,
                              widget.voucherColor,
                              widget.voucherColor
                            ],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.voucherText,
                        style: const TextStyle(
                            fontFamily: "Cairo",
                            fontSize: 19,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        widget.voucherDuration,
                        style: TextStyle(
                            fontFamily: "Cairo",
                            fontSize: 17,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                  Radio(
                    value: 0,
                    groupValue: selected,
                    onChanged: (value) {
                      print(widget.voucherText);
                      setState(() {
                        selected = value;
                      });
                    },
                    splashRadius: 50.0,
                  )
                ],
              ),
            ),
          )),
    );
  }
}
