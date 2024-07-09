import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahloula/Services/Data/cache_data.dart';
import 'package:mahloula/Services/State_Managment/Alll_Reservation_Page_Cubit/all_reserviation_page_cubit.dart';
import 'package:mahloula/Services/State_Managment/FeedBack_Cubit/feedback_cubit.dart';
import 'package:rating_dialog/rating_dialog.dart';
import '../../Models/reservation_model.dart';
import '../../Constants/Color_Constants.dart';
import 'package:mahloula/Pages/User_Pages/check_page.dart';

class CustomReserveCard extends StatefulWidget {
  const CustomReserveCard({
    Key? key,
    required this.color,
    required this.index,
    required this.reservation,
  }) : super(key: key);

  final Color color;
  final int index;
  final Reservation reservation;

  @override
  State<CustomReserveCard> createState() => _CustomReserveCardState();
}

class _CustomReserveCardState extends State<CustomReserveCard> {
  bool isTabed = false;

  String getStatusText() {
    if (widget.reservation.status == 'accepted') {
      return 'قادم';
    } else if (widget.reservation.status == 'rejected') {
      return 'ملغي';
    } else if (widget.reservation.status == 'waiting') {
      return 'انتظار';
    } else {
      return 'مكتمل';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Card(
        color: Colors.white38,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(color: Colors.black, width: 0.8),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 10),
                    child: Icon(Icons.maps_home_work_outlined),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 150,
                        child: Text(
                          widget.reservation.employeeName,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontFamily: "Cairo",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.reservation.serviceName,
                        style: const TextStyle(
                          fontFamily: "Cairo",
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 65,
                        height: 27,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(7),
                          color: widget.color,
                        ),
                        child: Center(
                          child: Text(
                            getStatusText(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Cairo',
                              fontSize: 13,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "$PartImagePath${widget.reservation.userImage}"),fit: BoxFit.cover),
                      color: MainColor,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
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
                              const SizedBox(
                                height: 3,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "الوقت والتاريخ",
                                    style: const TextStyle(
                                      fontFamily: "Cairo",
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    widget.reservation.dateOfDelivery,
                                    style: const TextStyle(
                                      fontFamily: "Cairo",
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "الموقع",
                                    style: const TextStyle(
                                      fontFamily: "Cairo",
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    widget.reservation.location.city,
                                    style: const TextStyle(
                                      fontFamily: "Cairo",
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              widget.reservation.status == "accepted"|| widget.reservation.status=="waiting"
                                  ? NextReserveButtons(
                                      reservation: widget.reservation)
                                  :widget.reservation.status == "completed"
                                      ? FeedbackAndResetBtns(
                                          reservation: widget.reservation)
                                      : widget.reservation.status == "rejected"
                                          ? CompletedAndCanceledReserveButton(
                                              btnFunctoin: () {
                                                BlocProvider.of<
                                                            AllReservitionPageCubit>(
                                                        context)
                                                    .changeOrderStatusForUser(
                                                        int.parse(widget
                                                            .reservation.id),
                                                        "waiting");
                                              },
                                              btnText: "اعادة الحجز",
                                            )
                                          : CompletedAndCanceledReserveButton(
                                              btnFunctoin: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CheckPage(
                                                            reservation: widget
                                                                .reservation),
                                                  ),
                                                );
                                              },
                                              btnText:
                                                  "عرض الفاتورة الالكترونية",
                                            ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isTabed = !isTabed;
                  });
                },
                icon: !isTabed
                    ? const Icon(
                        Icons.keyboard_arrow_down,
                        size: 40,
                      )
                    : const Icon(
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

class CompletedAndCanceledReserveButton extends StatelessWidget {
  final VoidCallback btnFunctoin;
  final String btnText;
  const CompletedAndCanceledReserveButton({
    Key? key,
    required this.btnFunctoin,
    required this.btnText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: btnFunctoin,
          style: ElevatedButton.styleFrom(
            backgroundColor: MainColor,
            side: const BorderSide(color: MainColor),
            elevation: 0,
            fixedSize: const Size(270, 25),
          ),
          child: Text(
            btnText,
            style: const TextStyle(
              fontFamily: "Cairo",
              fontSize: 13,
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

class NextReserveButtons extends StatefulWidget {
  final Reservation reservation;
  const NextReserveButtons({
    Key? key,
    required this.reservation,
  }) : super(key: key);

  @override
  State<NextReserveButtons> createState() => _NextReserveButtonsState();
}

class _NextReserveButtonsState extends State<NextReserveButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CardButton(
          btn_backgroung: MainColor,
          mainColor: Colors.white,
          btn_text: "عرض الفاتورة ",
          btn_function: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CheckPage(reservation: widget.reservation)),
            );
          },
        ),
        CardButton(
          btn_backgroung: Colors.white,
          mainColor: MainColor,
          btn_text: " الغاء الحجز",
          btn_function: () {
            BlocProvider.of<AllReservitionPageCubit>(context)
                .changeOrderStatusForUser(
                    int.parse(widget.reservation.id), "rejected");
          },
        ),
      ],
    );
  }
}

class FeedbackAndResetBtns extends StatefulWidget {
  final Reservation reservation;
  const FeedbackAndResetBtns({
    Key? key,
    required this.reservation,
  }) : super(key: key);

  @override
  State<FeedbackAndResetBtns> createState() => _FeedbackAndResetBtnsState();
}

class _FeedbackAndResetBtnsState extends State<FeedbackAndResetBtns> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CardButton(
          btn_backgroung: MainColor,
          mainColor: Colors.white,
          btn_text: "عرض الفاتورة ",
          btn_function: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CheckPage(reservation: widget.reservation)),
            );
          },
        ),
        CardButton(
          btn_backgroung: Colors.white,
          mainColor: MainColor,
          btn_text: "تقيم",
          btn_function: () {
            showDialog(
              context: context,
              barrierDismissible:
                  true, // set to false if you want to force a rating
              builder: (context) => FeedbackDialog(
                reservation: widget.reservation,
              ),
            );
            print("تقيم");
          },
        ),
      ],
    );
  }
}

class CardButton extends StatelessWidget {
  final Color btn_backgroung;
  final Color mainColor;
  final String btn_text;
  final VoidCallback btn_function;
  const CardButton({
    Key? key,
    required this.btn_backgroung,
    required this.mainColor,
    required this.btn_text,
    required this.btn_function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: btn_function,
      style: ElevatedButton.styleFrom(
        backgroundColor: btn_backgroung,
        side: BorderSide(color: mainColor),
        elevation: 0,
        fixedSize: const Size(135, 25),
      ),
      child: Text(
        btn_text,
        style: TextStyle(
          fontFamily: "Cairo",
          fontSize: 13,
          color: mainColor,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

Text checkStatus(int ind) {
  if (ind == 0) {
    return const Text(
      'ملغي',
      style: TextStyle(color: Colors.white, fontFamily: 'cairo', fontSize: 13),
    );
  } else if (ind == 1) {
    return const Text(
      'مكتمل',
      style: TextStyle(color: Colors.white, fontFamily: 'cairo', fontSize: 13),
    );
  } else {
    return const Text(
      'قادم',
      style: TextStyle(color: Colors.white, fontFamily: 'cairo', fontSize: 13),
    );
  }
}

class FeedbackDialog extends StatelessWidget {
  const FeedbackDialog({super.key, required this.reservation});
  final Reservation reservation;
  @override
  Widget build(BuildContext context) {
    return RatingDialog(
      submitButtonTextStyle: TextStyle(
          color: MainColor,
          fontFamily: "cairo",
          fontWeight: FontWeight.w700,
          fontSize: 21),
      starColor: MainColor,
      initialRating: 1.0,
      title: const Text(
        'تقييم الخدمة',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, fontFamily: "cairo"),
      ),
      message: const Text(
        '.نود معرفة رأيك في الخدمة التي تلقيتها مؤخرًا. يرجى ملء التفاصيل أدناه ',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15, fontFamily: "cairo"),
      ),
      image: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(70),
            image: DecorationImage(
                image: AssetImage("assets/photo/logo.png"), fit: BoxFit.cover),
          )),
      submitButtonText: 'ارسال',
      commentHint: 'تعليق',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print(reservation.id);
        BlocProvider.of<FeedbackCubit>(context).makeFeedback(
            empId: reservation.employeeId,
            Comment: response.comment,
            rating: (response.rating).truncate(),
            orderId: int.parse(reservation.id));
      },
    );
  }
}
