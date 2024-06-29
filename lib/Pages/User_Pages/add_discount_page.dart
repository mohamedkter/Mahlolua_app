import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mahloula/Models/voucher_model.dart';
import 'package:mahloula/Services/Api/get_methods.dart';
import 'package:mahloula/Widgets/custom_bottom_appbar.dart';
import 'package:mahloula/Widgets/voucher_card.dart';

class AddDiscountPage extends StatefulWidget {
  AddDiscountPage({super.key});

  @override
  _AddDiscountPageState createState() => _AddDiscountPageState();
}

class _AddDiscountPageState extends State<AddDiscountPage> {
   List<dynamic> vouchers = [];

  int? selectedVoucherIndex;

   @override
   void initState() {
     super.initState();
     fetchVouchers();
   }

   Future<void> fetchVouchers() async {
     vouchers = await GetMethods.getAllVouchers();
     setState(() {});
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: IconButton(
          onPressed: ()
          {
            // setState(() async {
            //   vouchers =  await GetMethods.getAllVouchers();
            // });
          },
          icon: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey.shade200,
            child: const Icon(Icons.refresh,size: 30,),
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
            vouchertype: vouchers[index]['type'],
            discount: vouchers[index]['discount'],
            voucherDuration: vouchers[index]['expired_at'],
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
