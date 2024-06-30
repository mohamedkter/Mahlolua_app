import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mahloula/Models/employee_profile_model.dart';
import 'package:mahloula/Models/order_model.dart';
import 'package:mahloula/Models/user_model.dart';
import 'package:mahloula/Pages/User_Pages/search_page.dart';
import 'package:mahloula/Services/Data/cache_data.dart';

import '../../Models/location_model.dart';
import '../../Pages/Service_Provider_Pages/all_worksImage_page.dart';

class PostMethods {
  static final Dio dio = Dio();
  static final Map<String, dynamic> headers = {
    'accept': '*/*',
    'Content-Type': 'application/json',
    // 'Authorization': 'Bearer '
  };

  // الطريقة الأولى لتحديث ملف التعريف الشخصي
  static Future<bool> updateEmployeeProfile({
    required int employeeId,
    String? name,
    String? description,
    int? minPrice,
    File? image,
  }) async {
    try {
      final String url = 'https://mahllola.online/api/employee/editEmployeeProfile/$employeeId';

      FormData formData = FormData.fromMap({
        if (name != null) 'name': name,
        if (description != null) 'des': description,
        if (minPrice != null) 'min_price': minPrice,
        if (image != null) 'image': await MultipartFile.fromFile(image.path, filename: 'profile_image.jpg'),
      });

      Response response = await dio.post(url, data: formData);
 
      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> updateWorkImages({
    required int employeeId,
    File? workImageOne,
    File? workImageTwo,
    File? workImageThree,
    File? workImageFour,
  }) async {
    try {
      final String url = 'https://mahllola.online/api/employee/updateWorksImage/$employeeId';

      FormData formData = FormData.fromMap({
        if (workImageOne != null) 'works[0][image]': await MultipartFile.fromFile(workImageOne.path, filename: 'work_image_1.jpg'),
        if (workImageTwo != null) 'works[1][image]': await MultipartFile.fromFile(workImageTwo.path, filename: 'work_image_2.jpg'),
        if (workImageThree != null) 'works[2][image]': await MultipartFile.fromFile(workImageThree.path, filename: 'work_image_3.jpg'),
        if (workImageFour != null) 'works[3][image]': await MultipartFile.fromFile(workImageFour.path, filename: 'work_image_4.jpg'),
      });

      Response response = await dio.post(url, data: formData);

      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }
////////////////////////////////////
static Future<bool> updateUserProfile({
    required int userid,
    String? name,
    
    
    File? image,
  }) async {
    try {
      final String url = 'https://mahllola.online/api/editUserProfile/$userid';

      FormData formData = FormData.fromMap({
        if (name != null) 'name': name,
        
        if (image != null) 'image': await MultipartFile.fromFile(image.path, filename: 'profile_image.jpg'),
      });

      Response response = await dio.post(url, data: formData);
 
      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }

//////////////////////////////// Make Order Method /////////////////////////////

   Future<dynamic> makeOrder(Order order) async {
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
        return true;
      } else {
        print('Failed to make order: ${response.statusCode}');
      return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('Error making order: ${e.response?.statusCode} - ${e.response?.statusMessage}');
        print('Response data: ${e.response?.data}');
        return false;
      } else {
      
        print('Error making order: ${e.message}');
        return false;
      }
    }
  }

  //////////////////// Update Work Images for employee ///////////////
  Future<bool> updateWorkImage(int userid, File? image,String name) async {
    try{
      final String url = 'https://mahllola.online/api/employee/updateWorksImage/$userid';
      FormData formData = FormData.fromMap({

        if (image != null) '$name': await MultipartFile.fromFile(image.path, filename: 'profile_image.jpg'),
      });
      Response response = await dio.post(url, data: formData);

      print('success');
      return response.statusCode == 200;
  } catch (e) {
  print(e);
  return false;
  }
    // try {
    //   //final formData = FormData.fromMap(elmId.toMap());
    //   if (image != null && image.files.isNotEmpty) {
    //     final imageFile = image.files.first;
    //     formData.files.addAll([imageFile]);
    //   }
    //   final response = await Dio().post(
    //     url,
    //     options: Options(
    //       headers: {
    //         'Content-Type': 'multipart/form-data',
    //       },
    //     ),
    //     data: formData,
    //   );

      // if (response.statusCode == 200) {
      //   print('Success: ${response.statusCode}');
      // } else {
      //   print('Failed to update work image: ${response.statusCode}');
      // }
    // } catch (e) {
    //   print('Error updating image: $e');
    // }
  }
//////////////////// Update Work Images for employee ///////////////
  Future<bool> updateProfileInfo(int userid, File? image,String imgName,String? name,String? desc,int? price) async {
    try{
      final String url = 'https://mahllola.online/api/employee/editEmployeeProfile/$userid';
      FormData formData = FormData.fromMap({
        if (name != null) 'name': name,
        if (desc != null) 'desc': desc,
        if (price != null) 'min_price': price,
        if (image != null) '$imgName': await MultipartFile.fromFile(image.path, filename:imgName),
      });
      formData.fields.forEach((field) {
        print('Field: ${field.key} = ${field.value}');
      });
      Response response = await dio.post(url, data: formData);

      print('success');
      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
    // try {
    //   //final formData = FormData.fromMap(elmId.toMap());
    //   if (image != null && image.files.isNotEmpty) {
    //     final imageFile = image.files.first;
    //     formData.files.addAll([imageFile]);
    //   }
    //   final response = await Dio().post(
    //     url,
    //     options: Options(
    //       headers: {
    //         'Content-Type': 'multipart/form-data',
    //       },
    //     ),
    //     data: formData,
    //   );

    // if (response.statusCode == 200) {
    //   print('Success: ${response.statusCode}');
    // } else {
    //   print('Failed to update work image: ${response.statusCode}');
    // }
    // } catch (e) {
    //   print('Error updating image: $e');
    // }
  }
  Future<dynamic> makeOrderWithVoucher(Order order, {String? code}) async {
    Map x = {'voucher_code':code};
    const String url = 'https://mahllola.online/api/makeOrder';
    final Dio dio = Dio();

    final headers = {
      //'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json',  // Adjust if needed
    };

    try {
      final Response response = await dio.post(
        url,
        queryParameters: order.toMap(),data: x['voucher_code'],
        options: Options(headers: headers),
      );

      // Handle the response
      if (response.statusCode == 200) {
        print('Order made successfully: ${response.data}');
        return true;
      } else {
        print('Failed to make order: ${response.statusCode}');
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('Error making order: ${e.response?.statusCode} - ${e.response?.statusMessage}');
        print('Response data: ${e.response?.data}');
        return false;
      } else {
        print('Error making order: ${e.message}');
        return false;
      }
    }
  }
////////////////////////////////  Delete Location /////////////////////////////////
static Future<void> deleteLocation(int id) async {
    const String url = 'https://mahllola.online/api/location/destroy/';

    final headers = {
      'accept': 'application/json',
      'X-CSRF-TOKEN': '',
    };

    try {
      final Response response = await dio.delete(
        '$url$id',
        options: Options(headers: headers),
      );

      // Handle the response
      if (response.statusCode == 200 || response.statusCode == 204) {
        print('Location deleted successfully');
      } else {
        print('Failed to delete location: ${response.statusCode}');
        print('Response data: ${response.data}');
      }
    } catch (e) {
      print('Exception: $e');
      if (e is DioError) {
        print('DioError message: ${e.message}');
        if (e.response != null) {
          print('DioError response data: ${e.response?.data}');
        }
      }
    }
  }  
//////////////////////////////// Make Location Method /////////////////////////////

  static Future<dynamic> makeLocation(LocationModel loc) async {
    const String url = 'https://mahllola.online/api/location/store';
    final Dio dio = Dio();

    final headers = {
      //'Authorization': 'Bearer $authToken',
       'accept': 'application/json',
      'Content-Type': 'multipart/form-data',  
    };
     print(loc.user_id);
          print(loc.city);
          print(loc.street);
          print(loc.bitTitle);
          print(loc.lat);
          print(loc.long);

 FormData formData = FormData.fromMap({
      'city': "${loc.city}",
      'bitTitle':"${loc.bitTitle}",
      'street': "${loc.street}",
      'specialMarque': "${loc.specialMarque}",
      'lat': "${loc.lat}",
      'long': "${loc.long}",
      'user_id': loc.user_id.toString(),
    });
    try {
      final Response response = await dio.post(
        url,
        data: formData,
        options: Options(headers: headers),
      );

      // Handle the response
      if (response.statusCode == 201) {
        print('Location stored successfully: ${response.data}');
        return response.data;
      } else {
        print('Failed to store location: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      print("fefeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      return null;
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

  static Future<dynamic> changeServiceProviderId(String state) async {
    final String url = 'https://mahllola.online/api/employee/changeEmployeeStatus/${CacheData.getData(key: "employee_id")}';

    final headers = {
      'Content-Type': 'application/json',
    };

    final body = {
      'status': state,
    };

    try {
      final Response response = await dio.post(
        url,
        data: body,
        options: Options(headers: headers),
      );

     if (response.statusCode == 200) {
      print(response.data);
        return response.data;
      } else {
        print('Failed to get employees: ${response.statusCode}');
        return null;
      }
    }catch (e) {
      return null;
    }
  }
   static Future<dynamic> makeFeedback(int empId,String Comment,int rating,int orderId) async {
    const String url = 'https://mahllola.online/api/makeFeedback';

    final headers = {
      'Content-Type': 'multipart/form-data',
    };
    final body = {
      'order_id':orderId,
      'employee_id':empId,
      'user_id':CacheData.getData(key: "userId"),
      'rating':rating,
      'comment':Comment
    };

    try {
      final Response response = await dio.post(
        url,
        data: body,
        options: Options(headers: headers),
      );

     if (response.statusCode == 200) {
      print(response.data);
        return response.data;
      } else {
        print('Failed to Make Feedback: ${response.statusCode}');
        return null;
      }
    }catch (e) {
      return null;
    }
  }
} 









