import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mahloula/Models/location_model.dart';
import 'package:mahloula/Services/Api/get_methods.dart';
import 'package:mahloula/Services/Api/post_methods.dart';
import 'package:mahloula/Services/Data/cache_data.dart';
import 'package:mahloula/Services/State_Managment/Address_Cubit/address_states.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(InitStateAddressState());
  Position? myPosition;
  Placemark? place;
  List<dynamic> locations = [];
  LatLng? latLng;
  Future<void> getMyLocatoin() async {
    emit(LoadingAddressState());
    myPosition = await _determinePosition();
    await updatePlacemark(LatLng(myPosition!.latitude, myPosition!.longitude));
    latLng = LatLng(myPosition!.latitude, myPosition!.longitude);
    emit(SuccessAddressState());
  }

  Future<void> updatePlacemark(LatLng location) async {
    emit(LoadingAddressState());
    List<Placemark>? placemarks =
        await placemarkFromCoordinates(location.latitude, location.longitude);
    if (placemarks != null) {
      place = placemarks[0];
      emit(SuccessAddressState());
    } else {
      emit(ErrorAddressState());
    }
  }

  Future<void> addAddress() async {
    emit(AddAddressState());
    dynamic res = await PostMethods.makeLocation(LocationModel(
        user_id: CacheData.getData(key: "userId"),
        city: place!.locality ?? "اسيوط",
        street: place!.street ?? " ",
        bitTitle: place!.name ?? " ",
        specialMarque: place?.subLocality ?? "mark",
        lat: latLng!.latitude,
        long: latLng!.longitude));
        
    res != null ? emit(AddAddressSuccessState()) : emit(ErrorAddressState());
  }

  Future<void> getAllAddresses() async {
    emit(LoadingAddressState());
    dynamic respo =
        await GetMethods.getAllLocations(CacheData.getData(key: "userId"));
    if (respo == null) {
      emit(ErrorAddressState());
    } else {
      locations = respo;
      emit(SuccessAddressState());
    }
  }

   Future<void> DeleteAddress(int id) async {
    emit(LoadingAddressState());
    await PostMethods.deleteLocation(id);
    getAllAddresses();
      emit(SuccessAddressState());
    }

  ///////////////////////////////////////////////////////////////

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
}
