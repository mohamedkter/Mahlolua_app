import 'package:dio/dio.dart';

class AuthMethods {
  static final Dio dio = Dio();
  static final Map<String, dynamic> headers = {
    'accept': '*/*',
    'Content-Type': 'application/json',
    'X-CSRF-TOKEN': '',
  };
/////////////////// login Method /////////////////////////////////
  static Future<dynamic?> login(String emailOrPhoneNumber, String password,) async {
    try {
      final response = await Dio().post(
        'https://mahllola.online/api/login',
        data: {
          'email_or_phone': emailOrPhoneNumber,
          'password': password,
        },
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        print("Login successful");
        print("User name: ${response.data["user"]["name"]}");
        return response;
      } else {
        print("Failed to login. Status code: ${response.statusCode}");
        throw Exception('Failed to login');
      }
    } catch (e) {
      print("Error during login: $e");
return null;       
    }
  }
}
