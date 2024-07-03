import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Models/location_model.dart';
import 'package:mahloula/Services/Api/post_methods.dart';
import 'package:mahloula/Services/Data/cache_data.dart';
import 'package:mahloula/Services/State_Managment/Address_Cubit/address_cubit.dart';
import 'package:mahloula/Services/State_Managment/Address_Cubit/address_states.dart';
import 'package:mahloula/Widgets/custom_bottom_appbar.dart';
import '../../Models/order_model.dart';
import '../../Services/Api/get_methods.dart';
import 'home_page.dart';

class GetLocationPage extends StatefulWidget {
  const GetLocationPage({this.obj, this.code, super.key});

  final String? code;
  final Order? obj;
  @override
  State<GetLocationPage> createState() => _GetLocationPageState();
}

class _GetLocationPageState extends State<GetLocationPage> {
  final formKey = GlobalKey<FormState>();
  MapType mapType = MapType.normal;
  List<Marker> marker = [];
  late LocationModel loc;
  double latitude = 0.0;
  double longitude = 0.0;
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AddressCubit>(context).getMyLocatoin();
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(27.185696, 31.176038),
    zoom: 14.4746,
  );
  Future<void> updateMyLocation(LatLng location) async {
    CameraPosition _kLake = CameraPosition(
        bearing: 192.8334901395799,
        target: location,
        tilt: 59.440717697143555,
        zoom: 18.151926040649414);
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
    setState(() {
      marker.add(Marker(markerId: MarkerId("1"), position: location));
    });
  }

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
        body: Stack(
          children: [
            GoogleMap(
              onTap: (LatLng location) async {
                CameraPosition _kLake = CameraPosition(
                    bearing: 192.8334901395799,
                    target: location,
                    tilt: 59.440717697143555,
                    zoom: 18.151926040649414);
                final GoogleMapController controller = await _controller.future;
                await controller
                    .animateCamera(CameraUpdate.newCameraPosition(_kLake));
                setState(() {
                  marker
                      .add(Marker(markerId: MarkerId("1"), position: location));
                });
                BlocProvider.of<AddressCubit>(context).latLng = location;
                BlocProvider.of<AddressCubit>(context)
                    .updatePlacemark(location);
              },
              markers: marker.toSet(),
              mapType: mapType,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            Positioned(
              left: 0,
              bottom: 40,
              child: Container(
                width: 100,
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25)),
                      child: IconButton(
                          onPressed: () {
                            if (BlocProvider.of<AddressCubit>(context)
                                    .myPosition !=
                                null) {
                              Position? myPosition =
                                  BlocProvider.of<AddressCubit>(context)
                                      .myPosition;
                              LatLng myLocation = LatLng(
                                  myPosition!.latitude, myPosition.longitude);
                              BlocProvider.of<AddressCubit>(context).latLng =
                                  myLocation;
                              updateMyLocation(myLocation);
                              BlocProvider.of<AddressCubit>(context)
                                  .updatePlacemark(myLocation);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      backgroundColor: Colors.white,
                                      content: Text(
                                        ".... الرجاء الانتطار",
                                        style: TextStyle(
                                            fontFamily: 'cairo',
                                            color: MainColor),
                                      )));
                            }
                          },
                          icon: const Icon(
                            Icons.near_me_outlined,
                            color: MainColor,
                            size: 25,
                          )),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25)),
                      child: IconButton(
                          onPressed: () {
                            mapType == MapType.normal
                                ? setState(() {
                                    mapType = MapType.satellite;
                                  })
                                : setState(() {
                                    mapType = MapType.normal;
                                  });
                          },
                          icon: const Icon(
                            Icons.map_outlined,
                            color: MainColor,
                            size: 25,
                          )),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: BlocBuilder<AddressCubit, AddressState>(
          builder: (context, state) {
            if (state is LoadingAddressState) {
              return CustomBottomAppBar(
                buttonText: ".... جاري تحديد الموقع",
                buttonFunction: () {},
              );
            } else if (state is AddAddressSuccessState) {
              return CustomBottomAppBar(
                buttonText: "تم اضافة الموقع لنقوم بستخدامه ",
                buttonFunction: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => HomePage(
                            name: CacheData.getData(key: "name"),
                          )));
                },
              );
            } else if (state is AddAddressState) {
              return CustomBottomAppBar(
                buttonText: ".... جاري اضافة الموقع",
                buttonFunction: () {},
              );
            } else if (state is SuccessAddressState) {
              return ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
                child: BottomAppBar(
                  height: 200,
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: 100,
                        child: Text(
                          BlocProvider.of<AddressCubit>(context)
                                  .place!
                                  .street ??
                              "",
                          style: const TextStyle(
                            fontFamily: "Cairo",
                            fontSize: 17,
                          ),
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.clip,
                          softWrap: true,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: MainColor,
                                  shadowColor: Colors.black,
                                  elevation: 1,
                                  fixedSize: Size(MediaQuery.of(context).size.width/1.2, 50)),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                          child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.2,
                                        height: 300,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: Colors.white),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 20),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Form(
                                                key: formKey,
                                                child: TextFormField(
                                                  validator: (value){
                                                    if (value=="") {
                                                      return " قم باضافة اختصار حتي تتم العمليه ";
                                                    }
                                                  },
                                                  autofocus: true,
                                                  style: const TextStyle(
                                                      fontSize: 20),
                                                  decoration: InputDecoration(
                                                      border: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.grey),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15))),
                                                  controller:
                                                      textEditingController,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              const Text(
                                                "قم باضافة وصف لهذا الموقع",
                                                style: TextStyle(
                                                  fontFamily: "Cairo",
                                                  fontSize: 20,
                                                  color: MainColor,
                                                ),
                                              ),
                                              const Text(
                                                "مثال : منزل , شركه",
                                                style: TextStyle(
                                                  fontFamily: "Cairo",
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          MainColor,
                                                      shadowColor: Colors.black,
                                                      elevation: 1,
                                                      fixedSize: Size(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1.4,
                                                          50)),
                                                  onPressed: () {
                                                    if (formKey.currentState!.validate()) {
                                                      BlocProvider.of<AddressCubit>(context).addAddress(textEditingController.text);
                                                    Navigator.of(context).pop();
                                                    }
                                                  },
                                                  child: const Text(
                                                    "اضف الموقع",
                                                    style: TextStyle(
                                                      fontFamily: "Cairo",
                                                      fontSize: 20,
                                                      color: Color.fromARGB(
                                                          255, 241, 242, 243),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ));
                                    });
                                
                              },
                              child: const Text(
                                "نعم هذا هو المكان",
                                style: TextStyle(
                                  fontFamily: "Cairo",
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 241, 242, 243),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return CustomBottomAppBar(
                  buttonText: "هذا المكان خارج النطاق", buttonFunction: () {});
            }
          },
        ));
  }
}
