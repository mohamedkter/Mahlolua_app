import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Functions/validation.dart';
import 'package:mahloula/Pages/Auth_Pages/create_profile_page.dart';
import 'package:mahloula/Pages/Auth_Pages/forget_password_page.dart';
import 'package:mahloula/Pages/Auth_Pages/regester_page.dart';
import 'package:mahloula/Pages/Loading_Pages/generel_loading_page.dart';
import 'package:mahloula/Pages/Service_Provider_Pages/service_provider_main_page.dart';
import 'package:mahloula/Pages/error_page.dart';
import 'package:mahloula/Pages/identify_page.dart';
import 'package:mahloula/Services/Api/auth_methods.dart';
import 'package:mahloula/Services/Data/cache_data.dart';

import '../User_Pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  bool is_loading = false;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: is_loading == true
          ? GenerelLoadingPage()
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'تسجيل الدخول إلى\n حسابك',
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            fontFamily: "cairo"),
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(height: 20),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          textDirection: TextDirection.rtl,
                          controller: _usernameController,
                          validator: (value) {
                            return validateEmail(value);
                          },
                          decoration: InputDecoration(
                              labelText: 'البريد الإلكتروني',
                              prefixIcon: Icon(Icons.email),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 174, 154, 154),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 174, 154, 154),
                                ),
                              )),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          textDirection: TextDirection.rtl,
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          validator: (value) {
                            return validateLoginPassword(value);
                          },
                          decoration: InputDecoration(
                              labelText: 'كلمة المرور',
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 174, 154, 154),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.white),
                              )),
                        ),
                      ),
                      SizedBox(height: 10),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('تذكرني'),
                              Checkbox(
                                value: _rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    _rememberMe = value ?? false;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  setState(() {
                                    is_loading = true;
                                  });
                                  var responseData = await AuthMethods.login(
                                      _usernameController.text.trim(),
                                      _passwordController.text.trim());
                                  if (responseData != null) {
                                    if (responseData.data["user"]["userType"] ==
                                        "user") {
                                      CacheData.setData(
                                          key: "userId",
                                          value: responseData.data["user"]
                                              ["id"]);
                                      CacheData.setData(
                                          key: "name",
                                          value: responseData.data["user"]
                                              ["name"]);
                                      CacheData.setData(
                                          key: "image",
                                          value: responseData.data["user"]
                                              ["image"]);
                                      CacheData.setData(
                                          key: "email",
                                          value: responseData.data["user"]
                                              ["email"]);
                                      CacheData.setData(
                                          key: "phone",
                                          value: responseData.data["user"]
                                              ["phone"]);
                                      CacheData.setData(
                                          key: "token",
                                          value: responseData
                                              .data["authorisation"]["token"]);

                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage(
                                                  name:
                                                      "${responseData.data["user"]["name"]}",
                                                )),
                                        (Route<dynamic> route) => false,
                                      );
                                    } else {
                                      CacheData.setData(
                                          key: "userId",
                                          value: responseData.data["user"]
                                              ["id"]);
                                      CacheData.setData(
                                          key: "name",
                                          value: responseData.data["user"]
                                              ["name"]);
                                      CacheData.setData(
                                          key: "image",
                                          value: responseData.data["user"]
                                              ["image"]);
                                      CacheData.setData(
                                          key: "email",
                                          value: responseData.data["user"]
                                              ["email"]);
                                      CacheData.setData(
                                          key: "employee_id",
                                          value: responseData.data["employee"]
                                              ["id"]);
                                      CacheData.setData(
                                          key: "phone",
                                          value: responseData.data["user"]
                                              ["phone"]);        
                                      CacheData.setData(
                                          key: "token",
                                          value: responseData
                                              .data["authorisation"]["token"]);
                                               Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ServiceProviderMainPage(name:"${responseData.data["user"]["name"]}")),
                                        (Route<dynamic> route) => false,
                                      );
                                    }
                                  } else {
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                            builder: (context) => ErrorPage(
                                                  upperMessage:
                                                      "خطا في تسجيل الدخول",
                                                  lowerMessage:
                                                      "يرجي التاكد من البريد الالكتروني او كلمة السر",
                                                )));
                                  }
                                }
                              },
                              child: Container(
                                height: 60,
                                width:
                                    650, // استخدام كل المساحة الأفقية المتاحة
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: MainColor, // لون الخلفية
                                  borderRadius: BorderRadius.circular(
                                      30.0), // زوايا مستديرة
                                ),
                                child: const Center(
                                  child: Text(
                                    'تسجيل الدخول',
                                    style: TextStyle(
                                        fontSize: 20.0, // حجم النص
                                        color: Colors.white,
                                        fontFamily: "cairo" // لون النص
                                        ),
                                  ),
                                ),
                              )),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPasswordPage()),
                              );
                            },
                            child: const Text(
                              'هل نسيت كلمة المرور؟',
                              style: TextStyle(
                                  color: Colors.black45, fontFamily: "cairo"),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 20, thickness: 1),
                      const Text(
                        'تسجيل بواسطة',
                        textAlign: TextAlign.center, // تحديث النص هنا
                        style: TextStyle(
                            fontSize: 18, // تكبير حجم النص إن كنت ترغب
                            fontWeight: FontWeight.bold,
                            fontFamily: "cairo"),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Socialimage(
                              image: Image.asset("assets/photo/facebook.png")),
                          SizedBox(width: 10),
                          Socialimage(
                              image: Image.asset("assets/photo/google.png")),
                          SizedBox(width: 10),
                          Socialimage(
                              image: Image.asset("assets/photo/apple.png")),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const IdentifyPage()),
                              );
                            },
                            child: const Text(
                              'إنشاء حساب',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "cairo"),
                            ),
                          ),
                          const Text(
                            'ليس لديك حساب؟ ',
                            style: TextStyle(fontFamily: "cairo"),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class Socialimage extends StatelessWidget {
  final Image image;

  Socialimage({required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 55,
        width: 81,
        margin: EdgeInsets.only(left: 18),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[200],
        ),
        child: image,
      ),
    );
  }
}
