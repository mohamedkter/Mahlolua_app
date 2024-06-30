import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Functions/date_converter.dart';
import 'package:mahloula/Models/reservation_model.dart';

class OrderDetailsPage extends StatefulWidget {
  OrderDetailsPage({super.key, required this.reservation});
  final Reservation reservation;

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  List<Marker> marker = [];
  static late CameraPosition _kGooglePlex;

  @override
  void initState() {
    super.initState();
    _kGooglePlex = CameraPosition(
      target: LatLng(
          widget.reservation.location.lat, widget.reservation.location.long),
      zoom: 14.4746,
    );
    marker.add(Marker(
        markerId: MarkerId("1"),
        position: LatLng(widget.reservation.location.lat,
            widget.reservation.location.long)));
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    List<String> DayAndHoures =
        convertToArabicTimeAndDate(widget.reservation.dateOfDelivery);

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "تفاصيل الطلب",
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold,
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage("assets/photo/logo.png"),
                  ),
                  color: MainColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 30,
                height: 30,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  children: [
                    RowOfData(
                      title: "اسم العميل",
                      value: widget.reservation.username,
                    ),
                    RowOfData(
                        title: "السعر",
                        value: "${widget.reservation.price} ج.م"),
                    RowOfData(
                        title: "الخدمه",
                        value: "${widget.reservation.serviceName}"),
                    RowOfData(title: "الساعه", value: DayAndHoures[0]),
                    RowOfData(title: "اليوم", value: DayAndHoures[1]),
                  ],
                ),
              ),
              const Divider(
                endIndent: 15,
                indent: 15,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    " :  وصف الطلب ",
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 15.0,
                      color: MainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Text(
                      widget.reservation.orderdescription,
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                      softWrap: true,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                endIndent: 15,
                indent: 15,
              ),
              const SizedBox(
                height: 15,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    " : الموقع ",
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 15.0,
                      color: MainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                height: 300,
                child: GoogleMap(
                  onTap: (LatLng location) async {},
                  markers: marker.toSet(),
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    " :  تفاصيل الموقع",
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 15.0,
                      color: MainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Text(
                      widget.reservation.location.street,
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                      softWrap: true,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RowOfData extends StatelessWidget {
  const RowOfData({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 1.7,
          child: Text(
            value,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          " :  $title ",
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 15.0,
            color: MainColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
