import 'package:flutter/material.dart';

class CreatePasswordPage extends StatefulWidget {
  @override
  _CreatePasswordPageState createState() => _CreatePasswordPageState();
}

enum PasswordCreationStatus {
  initial,
  matching,
  congratulations,
}

class _CreatePasswordPageState extends State<CreatePasswordPage> {
  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _passwordErrorText = '';
  PasswordCreationStatus _passwordCreationStatus =
      PasswordCreationStatus.initial;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Text(
              'انشاء كلمه سر جديده',
              style: TextStyle(fontFamily: 'cairo', fontSize: 21.0),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_passwordCreationStatus !=
                  PasswordCreationStatus.congratulations)
                TextFormField(
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
                          color: Colors.black,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white),
                      )),
                ),
              SizedBox(height: 16),
              if (_passwordCreationStatus !=
                  PasswordCreationStatus.congratulations)
                TextFormField(
                  controller: _confirmPasswordController,
                  textDirection: TextDirection.rtl,
                  obscureText: !_isPasswordVisible,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'يرجى اعاده إدخال كلمة المرور';
                    }
                  },
                  decoration: InputDecoration(
                      errorText: _passwordErrorText,
                      labelText: 'اعاده كلمة المرور',
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
                          color: Colors.black,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.black),
                      )),
                ),
              SizedBox(height: 16),
              GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate())
                    {
                      if (_passwordController.text == _confirmPasswordController.text) {
                        setState(() {
                          _passwordCreationStatus = PasswordCreationStatus.congratulations;
                          _passwordErrorText = '';
                        });
                      } else {
                        setState(() {
                          _passwordCreationStatus = PasswordCreationStatus.matching;
                          _passwordErrorText = 'الباسورد غير متطابق';
                        });
                      }
                    }
                  },
                  child: Container(
                    height: 60,
                    width: 650,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 20, 120, 226),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Center(
                      child: Text(
                        ' تاكيد',
                        style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.white,
                            fontFamily: 'cairo'),
                      ),
                    ),
                  )),
              if (_passwordCreationStatus ==
                  PasswordCreationStatus.congratulations)
                Container(
                  margin: EdgeInsets.only(top: 16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Congratulations!\nPassword created successfully!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: "cairo"),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
