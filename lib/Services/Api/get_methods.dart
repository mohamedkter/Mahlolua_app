import 'package:dio/dio.dart';
import 'package:mahloula/Models/employee_notification_model.dart';
import 'package:mahloula/Models/user_notification_model.dart';
import 'package:mahloula/Services/Data/cache_data.dart';
import '../../Models/voucher_model.dart';
import '../../Models/reservation_model.dart';

class GetMethods {
  static final Dio dio = Dio();
  static final Map<String, dynamic> headers = {
    'accept': '*/*',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${CacheData.getData(key: "token")}',
  };

////////////////////////////Get Employees ////////////////////////////////

  static Future<dynamic> getAllEmployeeInSpecificService(int serviceId) async {
    // id of service
    final String url =
        'https://mahllola.online/api/employee/showAllEmployeesByServiceId/$serviceId';
    try {
      final Response response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        print('employees details: ${response.data["allemployee"]}');
        return response.data["allemployee"];
      } else {
        print('Failed to get employees: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error getting employees: $e');
      return null;
    }
  }

////////////////////////Get All Order By User Id ////////////////////

  static Future<List<Reservation>> getUserOrders(int userId) async {
    final String url = 'https://mahllola.online/api/getUserOrders/$userId';
    try {
      final Response response = await dio.get(
        url,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        print("object");
        List<dynamic> data = response
            .data['message']; // Assuming the orders are under 'message' key
        return data.map((json) => Reservation.fromJson(json)).toList();
      } else {
        print('Failed to get user orders: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error getting user orders: $e');
      return [];
    }
  }

////////////////////////////////////////////// Get All Vouchers /////////////////////
  static Future<dynamic> getAllVouchers() async {
    final String url = 'https://mahllola.online/api/vouchers';
    try {
      final Response response = await dio.get(
        url,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        dynamic vouchers = response.data['vouchers'];
        return vouchers;
      } else {
        print('Failed to get Vouchers: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error getting Vouchers: $e');
      return null;
    }
  }

//////////////////////////////////////////////
  static Future<List<Reservation>> getEmployeeOrders(int employeeId) async {
    final String url =
        'https://mahllola.online/api/getEmployeeOrders/$employeeId';
    try {
      final Response response = await dio.get(
        url,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response
            .data['message']; // Assuming the orders are under 'message' key
        return data.map((json) => Reservation.fromJson(json)).toList();
      } else {
        print('Failed to get employee orders: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error getting employee orders: $e');
      return [];
    }
  }

////////////////////Get All Services ///////////////////////////

  static Future<dynamic> getAllServices() async {
    const String url = 'https://mahllola.online/api/services';
    try {
      final Response response = await dio.get(
        url,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        print('Services: ${response.data}');
        return response.data;
      } else {
        print('Failed to get services: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error getting services: $e');
      return null;
    }
  }

  ////////////////////Get All Locations By ID  ///////////////////////////

  static Future<dynamic> getAllLocations(int id) async {
    String url = 'https://mahllola.online/api/location/showUsersLocation/$id';
    try {
      final Response response = await dio.get(
        url,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        //print(response.data['locations']);
        return response.data['locations'];
      } else {
        print('Failed to get services: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error getting services: $e');
      return null;
    }
  }
  ////////////////////////// Get all Used Voucher by User ////////////////

  static Future<dynamic> getUsedVoucher() async {
    String url =
        'https://mahllola.online/api/showVouchersIsUsedByUser/${CacheData.getData(key: "userId")}';
    try {
      final Response response = await dio.get(
        url,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        return response.data['vouchers'];
      } else {
        print('Failed to get used voucher: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error getting used voucher: $e');
      return null;
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

  //////////////////// Get Work Images for employee ///////////////
  Future<Map> getWorkImages(int elmId, int index) async {
    final String url =
        'https://mahllola.online/api/employee/showEmployeeLastWorks/$elmId';
    try {
      final Response response = await dio.get(
        url,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        return response.data['Employee Work Image'][index];
      } else {
        print('Failed to get service details: ${response.statusCode}');
        return {};
      }
    } catch (e) {
      print('Error getting service details: $e');
      return {};
    }
  }

//////////////////// Get Count of Order for employee ///////////////

  static Future<int> getCountOrders(int employeId) async {
    final String url =
        'https://mahllola.online/api/employee/getTotalOrders/$employeId/orders/total';
    try {
      final Response response = await dio.get(
        url,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        print('Order details: ${response.data}');
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

  ////////////  Get all Sponsors /////////////////////////////
  static Future<dynamic> getSponsors() async {
    const String url = 'https://mahllola.online/api/sponsor';
    try {
      final Response response = await dio.get(
        url,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        print('Sponsors details: ${response.data}');
        return response.data["sponsor"];
      } else {
        print('Failed to get service details: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error getting service details: $e');
      return null;
    }
  }

////////////////////////////
  static Future<List<EmployeeNotification>> getEmployeeNotifications(
      int employeeId) async {
    final String url =
        'https://mahllola.online/api/employee/notifications/$employeeId';
    try {
      final Response response = await dio.get(
        url,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['message'];
        return data.map((json) => EmployeeNotification.fromJson(json)).toList();
      } else {
        print('Failed to get employee notifications: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error getting employee notifications: $e');
      return [];
    }
  }

  ////////////////////////////////
  static Future<List<UserNotification>> getUserNotifications(int userId) async {
    final String url = 'https://mahllola.online/api/user/notifications/$userId';
    try {
      final Response response = await dio.get(
        url,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data[
            'message']; // Assuming the notifications are under 'message' key
        return data.map((json) => UserNotification.fromJson(json)).toList();
      } else {
        print('Failed to get user notifications: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error getting user notifications: $e');
      return [];
    }
  }

  //////////////////// Get Feedback by service provider id ///////////////////
  static Future<dynamic> getFeedbacksByServiceProviderId(
      int serviceProviderId) async {
    final String url =
        'https://mahllola.online/api/getEmployeeFeedback/$serviceProviderId';
    try {
      final Response response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        print('employees feedbacks: ${response.data["message"]}');
        return response.data["message"];
      } else {
        print('Failed to get employees feedbacks: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error getting employees: $e');
      return null;
    }
  }

  static Future<dynamic> getServiceProviderProfile(
      int serviceProviderId) async {
    final String url =
        'https://mahllola.online/api/employee/employeeProfile/$serviceProviderId';
    try {
      final Response response = await dio.get(
        url,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        dynamic data = response.data['data'];
        return data;
      } else {
        print('Failed to get Service Provider Profile: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error getting Service Provider Profile: $e');
      return null;
    }
  }
}
