import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Models/order_model.dart';
import 'package:mahloula/Models/service_provider_model.dart';
import 'package:mahloula/Models/voucher_model.dart';
import 'package:mahloula/Pages/General_Pages/not_found_page.dart';
import 'package:mahloula/Pages/Loading_Pages/generel_loading_page.dart';
import 'package:mahloula/Pages/User_Pages/home_page.dart';
import 'package:mahloula/Services/Api/post_methods.dart';
import 'package:mahloula/Services/Data/cache_data.dart';
import 'package:mahloula/Services/State_Managment/Address_Cubit/address_cubit.dart';
import 'package:mahloula/Services/State_Managment/Address_Cubit/address_states.dart';
import 'package:mahloula/Widgets/custom_bottom_appbar.dart';

class CheckoutPage extends StatefulWidget {
  CheckoutPage(
      {super.key,
      required this.serviceProvider,
      required this.myOrder,
      required this.voucher});
  final ServiceProvider serviceProvider;
  Order? myOrder;
  final Voucher? voucher;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      BlocProvider.of<AddressCubit>(context).getAllAddresses();
  }
  int locationId = -1;
  String? cityname;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          const Text(
            "مراجعة الحجز",
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
        buttonText: "اتمام عملية الحجز",
        buttonFunction: () async {
          if (cityname != null) {
            widget.myOrder!.userId=CacheData.getData(key: "userId");
            widget.myOrder!.location = cityname;
            if (widget.voucher==null) {
           await PostMethods().makeOrder(widget.myOrder!);
              
            }else{
               PostMethods().makeOrderWithVoucher(widget.myOrder!,code: widget.voucher!.code);
            }
             Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomePage(name: CacheData.getData(key: "name"),)),(route) => false,);
          }else{
             ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  backgroundColor: MainColor,
                                  showCloseIcon: true,
                                  content: Column(
                                    children: [
                                      Text(
                                        "قم بختيار عنوان",
                                        style: TextStyle(
                                          fontFamily: "Cairo",
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        "يرجي اضافة او اختيار عنوان لاتمام الطلب",
                                        style: TextStyle(
                                          fontFamily: "Cairo",
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  )));
          }
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Card(
                color: Colors.white,
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: 100,
                                child: Text(
                                  widget.serviceProvider.user?.name ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      fontFamily: "Cairo",
                                      fontSize: 15,
                                      color: Colors.grey),
                                ),
                              ),
                              Container(
                                width: 150,
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Text(
                                    widget.serviceProvider.service!.name,
                                    style: const TextStyle(
                                        fontFamily: "Cairo",
                                        fontSize: 23,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                    softWrap: true,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Text(
                                "${widget.serviceProvider.minPrice}\$",
                                style: const TextStyle(
                                    fontFamily: "Cairo",
                                    fontSize: 24,
                                    color: MainColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "تقييم",
                                    style: TextStyle(
                                        fontFamily: "Cairo",
                                        fontSize: 15,
                                        color: Colors.grey),
                                  ),
                                  Text(
                                    "${widget.serviceProvider.total_rates ?? "0"}| ${widget.serviceProvider.average_rating ?? "0.0"}",
                                    style: const TextStyle(
                                        fontFamily: "Cairo",
                                        fontSize: 15,
                                        color: Colors.grey),
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                            image: widget.serviceProvider.user?.image != null
                                ? DecorationImage(
                                    image: NetworkImage(PartImagePath +
                                        "${widget.serviceProvider.user?.image}"),
                                    fit: BoxFit.cover)
                                : const DecorationImage(
                                    image: AssetImage(
                                        "assets/photo/profileImage.jpg"),
                                    fit: BoxFit.cover),
                            color: MainColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("ملخص الدفع",
                      style: TextStyle(
                          fontFamily: 'cairo',
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: MainColor))
                ],
              ),
              CustomPayRow(
                title: "المجموع الفرعي ",
                price: widget.myOrder!.price,
                fontsize: 15,
              ),
              const CustomPayRow(
                price: 0,
                title: "رسوم خدمه",
                fontsize: 15,
              ),
              CustomPayRow(
                price: widget.voucher == null ? 0 : -widget.voucher!.discount,
                title: "خصم",
                fontsize: 15,
              ),
              CustomPayRow(
                price: widget.voucher != null
                    ? widget.myOrder!.price! - widget.voucher!.discount
                    : widget.myOrder!.price,
                title: "المبلغ الاجمالي",
                fontsize: 18,
              ),
              const Divider(
                indent: 15,
                endIndent: 15,
              ),
              BlocBuilder<AddressCubit, AddressState>(
                builder: (context, state) {
                  if (state is SuccessAddressState) {
                    return SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: BlocProvider.of<AddressCubit>(context)
                                  .locations
                                  .length,
                              itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 5),
                                      child: Stack(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                locationId = BlocProvider.of<
                                                        AddressCubit>(context)
                                                    .locations[index]["id"];
                                                cityname = BlocProvider.of<
                                                        AddressCubit>(context)
                                                    .locations[index]["city"];
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: MainColor),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 55,
                                                          height: 30,
                                                          decoration: BoxDecoration(
                                                              color: locationId ==
                                                                      BlocProvider.of<AddressCubit>(context)
                                                                              .locations[index]
                                                                          ["id"]
                                                                  ? MainColor
                                                                  : Colors
                                                                      .white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              border: Border.all(
                                                                  color:
                                                                      MainColor)),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .location_on_outlined,
                                                                color: locationId !=
                                                                        BlocProvider.of<AddressCubit>(context).locations[index]
                                                                            [
                                                                            "id"]
                                                                    ? MainColor
                                                                    : Colors
                                                                        .white,
                                                                size: 15,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width: 150,
                                                              child: Text(
                                                                "${BlocProvider.of<AddressCubit>(context).locations[index]["specialMarque"]}",
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        "Cairo",
                                                                    fontSize:
                                                                        19,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 20,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Directionality(
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      child: Container(
                                                        width: 300,
                                                        child: Text(
                                                          "${BlocProvider.of<AddressCubit>(context).locations[index]["street"]}",
                                                          textAlign:
                                                              TextAlign.right,
                                                          style:
                                                              const TextStyle(
                                                            fontFamily: "Cairo",
                                                            fontSize: 17,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Directionality(
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      child: Text(
                                                          "${BlocProvider.of<AddressCubit>(context).locations[index]["city"]}"),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                        ],
                      ),
                    );
                  } else if (state is LoadingAddressState) {
                    return const Text("تحميل"); //GenerelLoadingPage();
                  } else {
                    return const NotFoundPage(
                      Message: "قم لا يوجد عناوين حتي الان",
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomPayRow extends StatelessWidget {
  const CustomPayRow({
    super.key,
    required this.price,
    required this.title,
    required this.fontsize,
  });
  final int? price;
  final String title;
  final double fontsize;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text("ج.م ",
                  style: TextStyle(
                    fontFamily: 'cairo',
                    fontSize: fontsize,
                  )),
              Text(price.toString() + ".00",
                  style: TextStyle(
                    fontFamily: 'cairo',
                    fontSize: 15,
                  ))
            ],
          ),
          Text(title,
              style: TextStyle(
                fontFamily: 'cairo',
                fontSize: 15,
              )),
        ],
      ),
    );
  }
}
