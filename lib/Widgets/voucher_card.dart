import 'package:flutter/material.dart';
import 'package:mahloula/Constants/Color_Constants.dart';

class VoucherCard extends StatelessWidget {
  final int index;
  final Color voucherColor;
  final String voucherText;
  final String voucherDuration;
  final int? selected;
  final ValueChanged<int?> onChanged;

  const VoucherCard({
    super.key,
    required this.voucherColor,
    required this.voucherText,
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
        height: 110,
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
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        voucherColor,
                        voucherColor,
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
                      voucherText,
                      style: const TextStyle(
                        fontFamily: "Cairo",
                        fontSize: 19,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      voucherDuration,
                      style: TextStyle(
                        fontFamily: "Cairo",
                        fontSize: 17,
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
