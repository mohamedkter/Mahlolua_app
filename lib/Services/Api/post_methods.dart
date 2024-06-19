import 'package:dio/dio.dart';
import 'package:mahloula/Models/employee_profile_model.dart';
import 'package:mahloula/Models/order_model.dart';
import 'package:mahloula/Models/user_model.dart';

class PostMethods {
  static final Dio dio = Dio();
  static final Map<String, dynamic> headers = {
    'accept': '*/*',
    'Content-Type': 'application/json',
    'X-CSRF-TOKEN': '',
  };

//////////////////////////////// Make Order Method /////////////////////////////
  static Future<void> makeOrder(Order order) async {
    const String url = 'https://mahllola.online/api/makeOrder';
    try {
      final Response response = await dio.post(
        url,
        queryParameters: order.toMap(),
        options: Options(headers: headers),
        data: {},
      );

      // Handle the response
      if (response.statusCode == 200) {
        print('Order made successfully: ${response.data}');
      } else {
        print('Failed to make order: ${response.statusCode}');
      }
    } catch (e) {
      print('Error making order: $e');
    }
  }


  ///////////////////////////// Create User Method //////////////////////////
  static Future<void> createUser(User user) async {
    const String url = 'https://mahllola.online/api/register';
    try {
      final Response response = await dio.post(
        url,
        options: Options(headers: headers),
        data: user.toMap(),
      );
      if (response.statusCode == 200) {
        print('User created successfully: ${response.data}');
      } else {
        print('Failed to create user: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating user: $e');
    }
  }

////////////////////////////////// Make Employee Profile Method ///////////////////////

  static Future<void> createEmployee(EmployeeProfile employee) async {
  const String url = 'https://mahllola.online/api/employee/addEmployee';
  try {
    final Response response = await dio.post(
      url,
      options: Options(headers: headers),
      data: employee.toMap(),
    );
    if (response.statusCode == 200) {
      print('Employee created successfully: ${response.data}');
    } else {
      print('Failed to create employee: ${response.statusCode}');
    }
  } catch (e) {
    print('Error creating employee: $e');
  }
}
////////////////////////////////edit Employee Method /////////////////////

// work on it later 





}
