import 'package:dio/dio.dart';

class AuthMethods {
  static final Dio dio = Dio();
  static final Map<String, dynamic> headers = {
    'accept': '*/*',
    'Content-Type': 'application/json',
    'X-CSRF-TOKEN': '',
  };
/////////////////// login Method /////////////////////////////////
static Future<dynamic> login(String email, String password) async {
  try {
    final response = await dio.post(
      'https://mahllola.online/api/login',
      queryParameters: {
        'email': email,
        'password': password,
      },
      options: Options(
        headers: headers,
      ),
    );
    print("???????????????????????????????????");
  print(response.data["user"]["name"]);
    print("???????????????????????????????????");


           return response;
   
  } catch (e) {
  print("errroorrrrrrrrrrrrrrrrrrrrrrrrr");
  }
}

}