import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mahloula/Models/voucher_model.dart';
import 'package:mahloula/Widgets/custom_bottom_appbar.dart';
import 'package:mahloula/Widgets/voucher_card.dart';

class AddDiscountPage extends StatefulWidget {
  AddDiscountPage({super.key});

  @override
  _AddDiscountPageState createState() => _AddDiscountPageState();
}

class _AddDiscountPageState extends State<AddDiscountPage> {
   List<Voucher> vouchers = [
    Voucher(
      id: 1,
      code: 'ABC123',
      type: 'percentage',
      discount: 10,
      status: 'active',
      expiredAt: DateTime.parse('2024-06-30').toString(),
    ),
    Voucher(
      id: 2,
      code: 'DEF456',
      type: 'fixed',
      discount: 50,
      status: 'expired',
      expiredAt: DateTime.parse('2023-12-31').toString(),
    ),
  ];

  int? selectedVoucherIndex;

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
            child: const Icon(Icons.search),
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
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: ListView.builder(
          itemBuilder: (context, index) => VoucherCard(
            index: index,
            vouchertype: vouchers[index].type,
            discount: vouchers[index].discount,
            voucherDuration: vouchers[index].expiredAt,
            selected: selectedVoucherIndex,
            onChanged: (int? value) {
              setState(() {
                selectedVoucherIndex = value;
              });
            },
          ),
          itemCount: vouchers.length,
        ),
      ),
      bottomNavigationBar: CustomBottomAppBar(
        buttonText: "تطبيق الخصم",
        buttonFunction: () {
      
          Navigator.pop(context,
              selectedVoucherIndex != null
                  ? vouchers[selectedVoucherIndex!]
                  : null);
        },
      ),
    );
  }
}
