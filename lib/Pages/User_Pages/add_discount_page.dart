import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Functions/date_converter.dart';
import 'package:mahloula/Models/voucher_model.dart';
import 'package:mahloula/Pages/General_Pages/not_found_page.dart';
import 'package:mahloula/Pages/Loading_Pages/generel_loading_page.dart';
import 'package:mahloula/Services/Api/get_methods.dart';
import 'package:mahloula/Services/State_Managment/Voucher_Cubit/voucher_cubit.dart';
import 'package:mahloula/Services/State_Managment/Voucher_Cubit/voucher_states.dart';
import 'package:mahloula/Widgets/custom_bottom_appbar.dart';
import 'package:mahloula/Widgets/voucher_card.dart';

class AddDiscountPage extends StatefulWidget {
  AddDiscountPage({super.key});

  @override
  _AddDiscountPageState createState() => _AddDiscountPageState();
}

class _AddDiscountPageState extends State<AddDiscountPage>
    with TickerProviderStateMixin {
  List<dynamic> vouchers = [];

  int? selectedVoucherIndex;
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.index = 2;
    BlocProvider.of<VoucherCubit>(context).getAllVoucher();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: IconButton(
          onPressed: () {
            BlocProvider.of<VoucherCubit>(context).getAllVoucher();
          },
          icon: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey.shade200,
            child: const Icon(
              Icons.refresh,
              size: 30,
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
            ),
          ),
        ],
        bottom: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: MainColor,
          indicatorWeight: 4,
          controller: _tabController,
          labelStyle: TextStyle(
              fontSize: 15.0,
              fontFamily: 'cairo',
              color: MainColor,
              fontWeight: FontWeight.w700),
          tabs: [
            Tab(text: 'انتهت'),
            Tab(text: 'استخدم'),
            Tab(text: 'صالح'),
          ],
        ),
      ),
      body: BlocBuilder<VoucherCubit, VoucherStates>(
        builder: (context, state) {
          if (state is VoucherSuccessState) {
            List<Voucher> availableVoucher =
                BlocProvider.of<VoucherCubit>(context).availableVoucher;
            List<Voucher> expiredVoucher =
                BlocProvider.of<VoucherCubit>(context).expiredVoucher;
            List<Voucher> usedVoucher =
                BlocProvider.of<VoucherCubit>(context).usedVoucher;

            return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    buildVoucherList(expiredVoucher),
                    buildVoucherList(usedVoucher),
                    buildAvailableVoucherList(availableVoucher),
                  ],
                ));
          } else if (state is VoucherLoadingState) {
            return const GenerelLoadingPage();
          } else {
            return const NotFoundPage(
              Message: "لا توجد قسائم متاحه لك",
            );
          }
        },
      ),
      bottomNavigationBar: CustomBottomAppBar(
        buttonText: "تطبيق الخصم",
        buttonFunction: () {
          Navigator.pop(
              context,
              selectedVoucherIndex != null
                  ? BlocProvider.of<VoucherCubit>(context)
                      .availableVoucher[selectedVoucherIndex ?? 0]
                  : null);
        },
      ),
    );
  }

  Widget buildAvailableVoucherList(List<Voucher> vouchers) {
    return vouchers.isEmpty
        ? const NotFoundPage(
            Message: "لا توجد قسائم متاحه لك ",
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return VoucherCard(
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
              );
            },
            itemCount: vouchers.length);
  }

  Widget buildVoucherList(List<Voucher> vouchers) {
    return vouchers.isEmpty
        ? const NotFoundPage(
            Message: "لا يوجد قسائم من هذا النوع",
          )
        : ListView.builder(
            itemBuilder: (context, index) {
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Image.asset("assets/photo/voucher.png"),
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Colors.white, Colors.grey],
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "خصم  ${vouchers[index].discount} ${vouchers[index].type == "fixed" ? "ج.م" : "%"}",
                                style: const TextStyle(
                                  fontFamily: "Cairo",
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                " الانتهاء في " +
                                    formatDate(vouchers[index].expiredAt),
                                style: TextStyle(
                                  fontFamily: "Cairo",
                                  fontSize: 15,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: vouchers.length);
  }
}
