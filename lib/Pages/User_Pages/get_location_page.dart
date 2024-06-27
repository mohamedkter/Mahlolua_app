import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mahloula/Models/location_model.dart';
import 'package:mahloula/Services/Api/post_methods.dart';
import 'package:mahloula/Services/Data/cache_data.dart';
import 'package:mahloula/Widgets/custom_bottom_appbar.dart';
import '../../Models/order_model.dart';
import '../../Services/Api/get_methods.dart';
import 'home_page.dart';

class GetLocationPage extends StatefulWidget {
  const GetLocationPage({this.obj,this.code, super.key});

  final String? code;
  final Order? obj;
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

  List<dynamic> locations = [];
  List<String> cities = [];
  TextEditingController textEditingController = TextEditingController();
  List<Marker> marker = [];
  TextEditingController descController = TextEditingController();
  late LocationModel loc;
  String city = '';
  String street = '';
  String bitTitle = '';
  double latitude = 0.0;
  double longitude = 0.0;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() async {
    Position myPosition = await _determinePosition();
    setState(() {
      myLocation = LatLng(myPosition.latitude, myPosition.longitude);
      latitude = myPosition.latitude;
      longitude = myPosition.longitude;
    });
    await _updatePlacemark(myLocation);
  }

  Future<void> _updatePlacemark(LatLng location) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        location.latitude, location.longitude);
    Placemark place = placemarks[0];
    setState(() {
      street = place.street ?? '';
      city = place.locality ?? '';
      bitTitle = place.name ?? '';
      latitude = location.latitude;
      longitude = location.longitude;
      textEditingController.text = "${place.locality}";
      print(textEditingController.text);
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
                    await _updatePlacemark(location);

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
                        onTap: ()  async {
                          locations = await GetMethods.getAllLocations(CacheData.getData(key: "userId"));
                          locations.forEach((element)
                          {
                            cities.add(element['city']);
                          });
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return ListView.builder(
                                itemCount: cities.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    title: Text(cities[index]),
                                    onTap: () {
                                      textEditingController.text = cities[index];
                                      print('Selected city: ${cities[index]}');
                                      //Navigator.pop(context); // Close the bottom sheet
                                    },
                                  );
                                },
                              );
                            },
                          );
                          // CameraPosition _kLake = CameraPosition(
                          //     bearing: 192.8334901395799,
                          //     target: LatLng(
                          //         myLocation.latitude, myLocation.longitude),
                          //     tilt: 59.440717697143555,
                          //     zoom: 19.151926040649414);
                          // final GoogleMapController controller =
                          // await _controller.future;
                          // await controller.animateCamera(
                          //     CameraUpdate.newCameraPosition(_kLake));
                          // setState(() {
                          //   marker.add(Marker(
                          //       markerId: MarkerId("1"),
                          //       position: LatLng(myLocation.latitude,
                          //           myLocation.longitude)));
                          // });
                          // await _updatePlacemark(myLocation);
                        },
                        child: const Icon(
                          Icons.location_on_outlined,
                          color: Color(0xff31589B),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: descController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'اكتب وصف المشكلة',
                      labelStyle: TextStyle(fontFamily: 'cairo'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomAppBar(
        buttonText: "تاكيد الحجز - \$${widget.obj?.price} ",
        buttonFunction: () {
             loc = LocationModel(
                user_id: CacheData.getData(key: "userId"),
                city: city,
                street: street,
                bitTitle: bitTitle,
                specialMarque: 'mark',
                lat: latitude,
                long: longitude
            );
          print(loc.user_id);
          print(loc.city);
          print(loc.street);
          print(loc.bitTitle);
          print(loc.lat);
          print(loc.long);
           PostMethods.makeLocation(loc);

          widget.obj?.userId = CacheData.getData(key: "userId");
          widget.obj?.location = textEditingController.text;
          widget.obj?.orderDescriptions = descController.text;
           if(widget.code != null){
             PostMethods().makeOrderWithVoucher(widget.obj!,code: widget.code!);
           }else
             {
               PostMethods().makeOrder(widget.obj!);
             }
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage(name: CacheData.getData(key: "name"),)));
        },
      ),
    );
  }
}
