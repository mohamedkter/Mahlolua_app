import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Constants/ObjectOrder.dart';
import 'package:mahloula/Models/reservation_model.dart';
import 'package:mahloula/Pages/Service_Provider_Pages/order_details_page.dart';
import 'package:mahloula/Pages/Service_Provider_Pages/service_provider_all_resevation_page.dart';
import 'package:mahloula/Pages/User_Pages/check_page.dart';
import 'package:mahloula/Services/State_Managment/Alll_Reservation_Page_Cubit/all_reserviation_page_cubit.dart';


class OrderCard extends StatefulWidget {
  final Reservation order;
  final Color color;
  final VoidCallback acceptedFunctoin;
  final VoidCallback rejectedFunctoin;
  const OrderCard({
    super.key,
    required this.color,
    required this.order,
    required this.acceptedFunctoin,
    required this.rejectedFunctoin,
  });

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
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
                    child: IconButton(
                      icon: const Icon(Icons.align_horizontal_left_rounded),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OrderDetailsPage(reservation: widget.order,)));
                      },
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.order.username,
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
                        widget.order.location.city,
                        style: TextStyle(
                            fontFamily: "Cairo",
                            fontSize: 15,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.order.dateOfDelivery,
                        style: const TextStyle(
                            fontFamily: "Cairo",
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/5,
                    height: 80,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "$PartImagePath${widget.order.userImage}"),
                            fit: BoxFit.cover),
                        color: MainColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30))),
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
                                    widget.order.dateOfDelivery,
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
                                    widget.order.location.city,
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
                                children: [
                                  Text(
                                    "الوصف :",
                                    style: TextStyle(
                                        fontFamily: "Cairo",
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.order.orderdescription,
                                      style: TextStyle(
                                          fontFamily: "Cairo",
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                      maxLines: 3,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              widget.order.status == "waiting"
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        OredrCardButton(
                                          btn_backgroung: MainColor,
                                          mainColor: Colors.white,
                                          btn_text: "قبول الطلب",
                                          btn_function: widget.acceptedFunctoin,
                                        ),
                                        OredrCardButton(
                                          btn_backgroung: Colors.white,
                                          mainColor: MainColor,
                                          btn_text: "رفض الطلب",
                                          btn_function: widget.rejectedFunctoin,
                                        )
                                      ],
                                    )
                                  : CompletedAndCanceledReserveButton(
                                      btnFunctoin: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => CheckPage(
                                                reservation: widget.order),
                                          ),
                                        );
                                      },
                                      btnText: "عرض الفاتوره الاكترونيه",
                                    )
                            ],
                          ),
                        ),
                      ))
                  : SizedBox(
                      height: 0,
                    ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isTabed = !isTabed;
                  });
                },
                icon: !isTabed
                    ? Icon(
                        Icons.keyboard_arrow_down,
                        size: 40,
                      )
                    : Icon(
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

class OredrCardButton extends StatelessWidget {
  final Color btn_backgroung;
  final Color mainColor;
  final String btn_text;
  final VoidCallback btn_function;
  const OredrCardButton({
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
            fixedSize: Size(140, 25)),
        child: Text(
          btn_text,
          style: TextStyle(
              fontFamily: "Cairo",
              fontSize: 15,
              color: mainColor,
              fontWeight: FontWeight.w800),
        ));
  }
}
