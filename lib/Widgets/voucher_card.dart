import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Functions/date_converter.dart';

class VoucherCard extends StatelessWidget {
  final int index;
  final String vouchertype;
  final int discount;
  final String voucherDuration;
  final int? selected;
  final ValueChanged<int?> onChanged;

  const VoucherCard({
    super.key,
    required this.vouchertype,
    required this.discount,
    required this.voucherDuration,
    required this.index,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0.4),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
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
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        vouchertype=="fixed"? MainColor:const Color.fromARGB(255, 66, 122, 68)
                      ],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "خصم  ${discount} ${vouchertype=="fixed"?"ج.م":"%"}",
                      style: const TextStyle(
                        fontFamily: "Cairo",
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "ينتهي في ${formatDate(voucherDuration)}",
                      style: TextStyle(
                        fontFamily: "Cairo",
                        fontSize: 15,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                Radio<int>(
                  activeColor: MainColor,
                  value: index,
                  groupValue: selected,
                  onChanged: onChanged,
                  splashRadius: 50.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
