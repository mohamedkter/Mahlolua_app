import 'package:dio/dio.dart';
import 'package:mahloula/Services/Data/cache_data.dart';

class GetMethods {
  static final Dio dio = Dio();
  static final Map<String, dynamic> headers = {
    'accept': '*/*',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${CacheData.getData(key:"token")}',
  };

////////////////////////////Get Employees ////////////////////////////////


  static Future<void> getAllEmployeeInSpecificService(int serviceId) async {
    // id of service
    final String url = 'https://mahllola.online/api/employees/$serviceId';
    try {
      final Response response = await dio.get(
        url,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        print('Employee details: ${response.data}');
      } else {
        print('Failed to get employee details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error getting employee details: $e');
    }
  }

////////////////////////Get All Order By User Id ////////////////////

static Future<void> getUserOrders(int userId) async {
  final String url = 'https://mahllola.online/api/getUserOrders/$userId';
  try {
    final Response response = await dio.get(
      url,
      options: Options(headers: headers),
    );
    if (response.statusCode == 200) {
      print('User orders: ${response.data}');
    } else {
      print('Failed to get user orders: ${response.statusCode}');
    }
  } catch (e) {
    print('Error getting user orders: $e');
  }
}


////////////////////Get All Services ///////////////////////////

static Future<void> getAllServices() async {
  const String url = 'https://mahllola.online/api/services';
  try {
   
    final Response response = await dio.get(
      url,
      options: Options(headers: headers),
    );

    if (response.statusCode == 200) {
      print('Services: ${response.data}');
    } else {
      print('Failed to get services: ${response.statusCode}');
    }
  } catch (e) {
    print('Error getting services: $e');
  }
}

////////////////////////Get Service By Id ////////////

Future<void> getServiceDetails(int serviceId) async {
  final String url = 'https://mahllola.online/api/services/$serviceId';
  try {
    final Response response = await dio.get(
      url,
      options: Options(headers: headers),
    );
  
    if (response.statusCode == 200) {
      print('Service details: ${response.data}');
    } else {
      print('Failed to get service details: ${response.statusCode}');
    }
  } catch (e) {
    print('Error getting service details: $e');
  }
}


//////////////////// Get Count of Order for employee ///////////////

static Future<int> getCountOrders(int employeId) async {
  final String url = 'https://mahllola.online/api/employee/getTotalOrders/$employeId/orders/total';
  try {
    final Response response = await dio.get(
      url,
      options: Options(headers: headers),
    );
  
    if (response.statusCode == 200) {
      print('Service details: ${response.data}');
      return response.data["total orders"];
    } else {
      print('Failed to get service details: ${response.statusCode}');
      return -1;
    }
  } catch (e) {
    print('Error getting service details: $e');
    return -1;
  }
}






}