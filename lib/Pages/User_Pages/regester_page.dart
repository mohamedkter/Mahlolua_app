
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Functions/image_converter.dart';
import 'package:mahloula/Models/user_model.dart';
import 'package:mahloula/Pages/User_Pages/login_page.dart';
import 'package:mime/mime.dart';
import '../../Services/Api/post_methods.dart';
import '../Service_Provider_Pages/service_provider_credentials_page.dart';

class SignupPage extends StatefulWidget {
  SignupPage({this.type, super.key});

  final String? type;
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _isPasswordVisible = false;
  File? _image;
  bool _rememberMe = false;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          ' انشاء الحساب',
          style: TextStyle(fontFamily: 'cairo'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'قم بانشاء\nحسابك',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'cairo'),
                  textAlign: TextAlign.right,
                ),
                SizedBox(height: 20),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    textDirection: TextDirection.rtl,
                    controller: _nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'يرجى إدخال الاسم الاول';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'الاسم الاول',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 174, 154, 154),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.white),
                        )),
                  ),
                ),
                SizedBox(height: 20),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    textDirection: TextDirection.rtl,
                    controller: _lastnameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'يرجى إدخال الاسم الاخير';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'الاسم الاخير',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 174, 154, 154),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(30),
                        )),
                  ),
                ),
                SizedBox(height: 20),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    textDirection: TextDirection.rtl,
                    controller: _phoneController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'يرجى إدخال رقم الهاتف';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'رقم الهاتف',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 174, 154, 154),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(30),
                        )),
                  ),
                ),
                SizedBox(height: 20),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    textDirection: TextDirection.rtl,
                    controller: _usernameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'يرجى إدخال البريد الإلكتروني';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'البريد الإلكتروني',
                        prefixIcon: Icon(Icons.email),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 174, 154, 154),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(30),
                        )),
                  ),
                ),
                SizedBox(height: 20),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    textDirection: TextDirection.rtl,
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'يرجى إدخال كلمة المرور';
                      }
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
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 174, 154, 154),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(30),
                        )),
                  ),
                ),
                SizedBox(height: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _image == null
                        ? Text('لم يتم اختيار صورة')
                        : Image.file(_image!),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: Text('اضغط لاختيار الصورة'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'تذكرني',
                          style: TextStyle(fontFamily: 'cairo'),
                        ),
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
                    SizedBox(height: 20),
                    GestureDetector(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            if (widget.type == 'user') {
                              User obj = User(
                                name: _nameController.text,
                                email: _usernameController.text,
                                password: _passwordController.text,
                                phone: _phoneController.text,
                                userType: widget.type,
                              );
                              FormData? image = _image == null
                                  ? null
                                  : await imageConverter(_image!);
                              await PostMethods.createUser(obj, image);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ServiceProviderCredentials()),
                              );
                            }
                          }
                        },
                        child: Container(
                          height: 60,
                          width: 650, // استخدام كل المساحة الأفقية المتاحة
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: MainColor,
                            borderRadius:
                                BorderRadius.circular(30.0), // زوايا مستديرة
                          ),
                          child: const Center(
                            child: Text("انشاء حساب",
                              style: TextStyle(
                                  fontSize: 20.0, // حجم النص
                                  color: Colors.white,
                                  fontFamily: "cairo" // لون النص
                                  ),
                            ),
                          ),
                        )),
                    SizedBox(height: 10),
                  ],
                ),
                Divider(height: 30, thickness: 1),
                const Text(
                  'تسجيل بواسطة',
                  textAlign: TextAlign.center, // تحديث النص هنا
                  style: TextStyle(
                      fontSize: 18, // تكبير حجم النص إن كنت ترغب
                      fontWeight: FontWeight.bold,
                      fontFamily: "cairo"),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Socialimage(
                        image: Image.asset("assets/photo/facebook.png")),
                    SizedBox(width: 10),
                    Socialimage(image: Image.asset("assets/photo/google.png")),
                    SizedBox(width: 10),
                    Socialimage(image: Image.asset("assets/photo/apple.png")),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //---------Pick Image Function------------

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        
      });
    } else {
      print('No image selected.');
    }
  }
}

class Socialimage extends StatelessWidget {
  final Image image;

  Socialimage({required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 81,
      margin: EdgeInsets.only(left: 18),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[200],
      ),
      child: image,
    );
  }
}



