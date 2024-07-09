import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mahloula/Models/order_model.dart';
import 'package:mahloula/Models/service_provider_model.dart';
import 'package:mahloula/Models/voucher_model.dart';
import 'package:mahloula/Pages/User_Pages/checkout%20page.dart';
import 'package:mahloula/Widgets/custom_bottom_appbar.dart';

class GetOrderDescription extends StatelessWidget {
   GetOrderDescription({super.key, required this.serviceProvider, required this.myOrder, required this.voucher});
   final  ServiceProvider serviceProvider;
   Order? myOrder;
   final Voucher? voucher;
  @override
  Widget build(BuildContext context) {
    TextEditingController descController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          const Text(
            "وصف المشكلة",
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
      bottomNavigationBar: CustomBottomAppBar(
        buttonText: "التالي",
        buttonFunction: () {
          if (_formKey.currentState!.validate()) {
         myOrder?.orderDescriptions=descController.text; 
          Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    CheckoutPage(myOrder: myOrder, serviceProvider:serviceProvider,voucher: voucher,)));
          }
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    maxLines: 10,
                    controller: descController,
                    decoration: InputDecoration(
                      hintTextDirection: TextDirection.rtl,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'اكتب وصف المشكلة',
                      labelStyle: TextStyle(fontFamily: 'cairo'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'من فضلك أدخل وصف المشكلة';
                       } 
                      //else if (!RegExp(r'^(.*?\s.*?){1,}').hasMatch(value)) {
                      //   return 'من فضلك أدخل جملة واحدة على الأقل';
                      // }
                      return null;
                    },
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: Text(
                  "من فضلك اتبع التعليمات التالية",
                  style: TextStyle(
                      fontFamily: 'cairo',
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
              ),
               Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 300,
                      child: Text(
                        "حدد الغرفة أو المكان الذي تحدث فيه المشكلة",
                        style: TextStyle(fontFamily: 'cairo', fontSize: 18),
                        softWrap: true,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "اشرح المشكلة بشكل واضح ومختصر",
                      style: TextStyle(fontFamily: 'cairo', fontSize: 18),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "اذكر متى بدأت المشكلة وعدد مرات تكرارها",
                      style: TextStyle(fontFamily: 'cairo', fontSize: 18),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 300,
                      child: const Text(
                        "اذكر إذا كنت قد قمت بأي محاولات لإصلاح المشكلة بنفسك",
                        textAlign: TextAlign.right,
                        softWrap: true,
                        style: TextStyle(fontFamily: 'cairo', fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
