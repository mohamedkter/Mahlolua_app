import 'package:dio/dio.dart';
import 'package:mahloula/Models/employee_profile_model.dart';
import 'package:mahloula/Models/order_model.dart';
import 'package:mahloula/Models/user_model.dart';
import 'package:mahloula/Pages/User_Pages/search_page.dart';
import 'package:mahloula/Services/Data/cache_data.dart';

class PostMethods {
  static final Dio dio = Dio();
  static final Map<String, dynamic> headers = {
    'accept': '*/*',
    'Content-Type': 'application/json',
  //  'Authorization': 'Bearer '
  };

//////////////////////////////// Make Order Method /////////////////////////////

  static Future<void> makeOrder(Order order) async {
    const String url = 'https://mahllola.online/api/makeOrder';
    final Dio dio = Dio();

    final headers = {
      //'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json',  // Adjust if needed
    };

    try {
      final Response response = await dio.post(
        url,
        queryParameters: order.toMap(),
        options: Options(headers: headers),
      );

      // Handle the response
      if (response.statusCode == 200) {
        print('Order made successfully: ${response.data}');
      } else {
        print('Failed to make order: ${response.statusCode}');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('Error making order: ${e.response?.statusCode} - ${e.response?.statusMessage}');
        print('Response data: ${e.response?.data}');
      } else {
        print('Error making order: ${e.message}');
      }
    }
  }


  ///////////////////////////// Create User Method //////////////////////////
  
  static Future<dynamic> createUser(User user, FormData? image) async {
  const String url = 'https://mahllola.online/api/register'; 
  try {
    final formData = FormData.fromMap(user.toMap());
    if (image != null && image.files.isNotEmpty) {
      final imageFile = image.files.first;
        formData.files.addAll([imageFile]);
    }
    final response = await Dio().post(
      url,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      ),
      data: formData,
    );

    
    if (response.statusCode == 200) {
      print('User created successfully: ${response.data}');
      return response.data;
    } else {
      if (response.statusCode == 400) {
        print('Bad request: ${response.data}');
        return null;
      } else {
        print('Failed to create user: ${response.statusCode}');
      return null;
      }
    }
  } catch (e) {
    print('Error creating user: $e');
    return null;
  }
}

////////////////////////////////// Make Employee Profile Method ///////////////////////

 static Future<bool> createEmployee(
    EmployeeProfile employee,
    FormData? imageSSN,
    FormData? livePhoto,
    FormData? works0,
    FormData? works1,
    FormData? works2,
    FormData? works3
) async {
  const String url = 'https://mahllola.online/api/employee/employeeCompleteData';
  final formData = FormData.fromMap(employee.toMap());

  void addFileToFormData(FormData? formData, FormData? fileData) {
    if (fileData != null && fileData.files.isNotEmpty) {
      formData?.files.addAll(fileData.files);
    }
  }

  addFileToFormData(formData, imageSSN);
  addFileToFormData(formData, livePhoto);
  addFileToFormData(formData, works0);
  addFileToFormData(formData, works1);
  addFileToFormData(formData, works2);
  addFileToFormData(formData, works3);

  try {
    final response = await Dio().post(
      url,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      ),
      data: formData,
    );

    if (response.statusCode == 200) {
      print('Employee created successfully: ${response.data}');
      return true;

    } else {
      print('Failed to create employee: ${response.statusCode}');
      print('Response data: ${response.data}');
      return false;
    }
  } catch (e) {
   return false;
  }
}
////////////////////////////////edit Employee Method /////////////////////

static Future<void> changeOrderStatus(int orderId, String newStatus) async {
    final String url = 'https://mahllola.online/api/changeOrderStatus/$orderId';

    final headers = {
      'Content-Type': 'application/json',
    };

    final body = {
      'status': newStatus,
    };

    try {
      final Response response = await dio.post(
        url,
        data: body,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        print('Order status changed successfully: ${response.data}');
      } else {
        print('Failed to change order status: ${response.statusCode}');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('Error changing order status: ${e.response?.statusCode} - ${e.response?.statusMessage}');
        print('Response data: ${e.response?.data}');
      } else {
        print('Error changing order status: ${e.message}');
      }
    }
  }

  
static Future<dynamic> SearchFunction(String query) async {
    final String url = 'https://mahllola.online/api/employee/search';

    final headers = {
      'Content-Type': 'application/json',
    };

    final body = {
      'query': query,
    };

    try {
      final Response response = await dio.post(
        url,
        data: body,
        options: Options(headers: headers),
      );

     if (response.statusCode == 200) {
        print('employees details: ${response.data["allemployee"]}');
        return response.data["allemployee"];
      } else {
        print('Failed to get employees: ${response.statusCode}');
        return null;
      }
    }catch (e) {
      return null;
    }
  }
} 









