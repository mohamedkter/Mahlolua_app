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
    'Authorization': 'Bearer ${CacheData.getData(key:"token")}',
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
  static Future<dynamic> createUser(User user, FormData? image) async {
  const String url = 'https://mahllola.online/api/register'; 

  try {
    
    if (user.name == null || user.email == null || !user.email.contains('@')) {
      throw Exception('Missing required user data');
    }

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

 static Future<void> createEmployee(
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
    } else {
      print('Failed to create employee: ${response.statusCode}');
      print('Response data: ${response.data}');
    }
  } on DioException catch (e) {
    if (e.response != null) {
      print('Dio error! Status: ${e.response?.statusCode}, Data: ${e.response?.data}');
    } else {
      print('Error sending request: ${e.message}');
    }
  } catch (e) {
    print('Unexpected error: $e');
  }
}
////////////////////////////////edit Employee Method /////////////////////

// work on it later 




}




