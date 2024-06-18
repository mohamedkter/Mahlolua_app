import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mahloula/Widgets/custom_bottom_appbar.dart';

class GetLocationPage extends StatefulWidget {
  const GetLocationPage({super.key});

  @override
  State<GetLocationPage> createState() => _GetLocationPageState();
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  return await Geolocator.getCurrentPosition();
}

class _GetLocationPageState extends State<GetLocationPage> {
  LatLng myLocation = LatLng(27.185696, 31.176038);

  TextEditingController textEditingController = TextEditingController();
  List<Marker> marker = [];
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() async {
    Position myPostion = await _determinePosition();
    setState(() {
      myLocation = LatLng(myPostion.latitude, myPostion.longitude);
    });
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(27.185696, 31.176038),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: IconButton(
          onPressed: () {},
          icon: CircleAvatar(
            radius: 17,
            backgroundColor: Colors.grey.shade200,
            child: const Icon(
              Icons.more_horiz,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          const Text(
            "العنوان / الموقع",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height / 2,
                child: GoogleMap(
                  onTap: (LatLng location) async {
                    CameraPosition _kLake = CameraPosition(
                        bearing: 192.8334901395799,
                        target: location,
                        tilt: 59.440717697143555,
                        zoom: 18.151926040649414);
                    final GoogleMapController controller =
                        await _controller.future;
                    await controller
                        .animateCamera(CameraUpdate.newCameraPosition(_kLake));
                    setState(() {
                      marker.add(
                          Marker(markerId: MarkerId("1"), position: location));
                    });
                    List<Placemark> placemarks = await placemarkFromCoordinates(
                        location.latitude, location.longitude);
                    Placemark place = placemarks[0];
                    textEditingController.text = "${place.street},";
                  },
                  markers: marker.toSet(),
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 70,
                child: const Text(
                  "تفاصيل الموقع",
                  style: TextStyle(
                      fontFamily: 'cairo',
                      fontSize: 27.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const Divider(
                thickness: 0.4,
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "العنوان",
                  style: TextStyle(
                      fontFamily: 'cairo',
                      fontSize: 19.0,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    readOnly: true,
                    controller: textEditingController,
                    style: const TextStyle(
                      fontFamily: "Cairo",
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(
                        fontFamily: "Cairo",
                        fontSize: 18,
                        color: Color.fromARGB(255, 118, 115, 115),
                      ),
                      hintText: "ميدان الازهر , اسيوط",
                      focusedBorder: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none),
                      border: InputBorder.none,
                      fillColor: Color(0xfff1E7ff),
                      filled: true,
                      suffixIcon: GestureDetector(
                        onTap: () async {
                          CameraPosition _kLake = CameraPosition(
                              bearing: 192.8334901395799,
                              target: LatLng(
                                  myLocation.latitude, myLocation.longitude),
                              tilt: 59.440717697143555,
                              zoom: 19.151926040649414);
                          final GoogleMapController controller =
                              await _controller.future;
                          await controller.animateCamera(
                              CameraUpdate.newCameraPosition(_kLake));
                          setState(() {
                            marker.add(Marker(
                                markerId: MarkerId("1"),
                                position: LatLng(myLocation.latitude,
                                    myLocation.longitude)));
                          });
                          List<Placemark> placemarks =
                              await placemarkFromCoordinates(
                                  myLocation.latitude, myLocation.longitude);
                          Placemark place = placemarks[0];
                          textEditingController.text = "${place.street},";
                        },
                        child: Icon(
                          Icons.location_on_outlined,
                          color: Color(0xff31589B),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomAppBar(
        buttonText: "تاكيد الحجز - \$100 ",
        buttonFunction: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => GetLocationPage()));
        },
      ),
    );
  }
}
