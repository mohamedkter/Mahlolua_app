import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mahloula/Models/voucher_model.dart';
import 'package:mahloula/Widgets/custom_bottom_appbar.dart';
import 'package:mahloula/Widgets/voucher_card.dart';

class AddDiscountPage extends StatelessWidget {
  AddDiscountPage({super.key});
  final List<Voucher> Vouchers = [
    Voucher("خصم 30% مميز", "عرض مميز خمس ايام ", 30),
    Voucher("خصم 20% مميز", "عرض مميز الجمعة فقط ", 20),
    Voucher("خصم 40% مميز", "عرض مميز اليوم فقط", 40),
    Voucher("خصم 25% مميز", "عرض مميز الجمعة فقط ", 25),
    Voucher("خصم 15% مميز", "عرض مميز خمس ايام ", 15),
    Voucher("خصم 10% مميز", "عرض مميز اليوم فقط", 10),
    Voucher("خصم 25% مميز", "عرض مميز الجمعة فقط ", 25),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: IconButton(
          onPressed: () {},
          icon: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey.shade200,
            child: const Icon(
              Icons.search,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          const Text(
            "اضف خصم",
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
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: ListView.builder(
            itemBuilder: (context, index) => VoucherCard(
              voucherColor: Color.fromARGB(255, Random().nextInt(255),
                  Random().nextInt(255), Random().nextInt(255)),
              voucherText:Vouchers[index].voucher_Text,
              voucherDuration:Vouchers[index].voucher_Duration,
            ),
            itemCount:Vouchers.length,
          )),
            bottomNavigationBar: CustomBottomAppBar(buttonText:"تطبيق الخصم",buttonFunction: () {},),
    );
  }
}
