import 'package:flutter/material.dart';
import 'package:mahloula/Pages/User_Pages/verivecation_page.dart';



class ForgotPasswordPage extends StatelessWidget {

  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_rounded),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Text(
                'نسيت كلمه السر',
                style: TextStyle(
                    fontSize: 31.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'cairo'),
              ),
            ),
          ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/photo/img_1.png', // استبدلها بمسار الصورة الخاصة بك
                  width: 250,
                  height: 250,
                ),
                SizedBox(
                  height: 22,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: controller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'يرجى إدخال رقم الهاتف';
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'يرجى إدخال رقم الهاتف',
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                'ارسال SMS',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              CircleAvatar(
                                  radius: 27.0,
                                  child: Icon(
                                    Icons.sms_rounded,
                                    size: 30,
                                  )),
                            ],
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 174, 154, 154),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 174, 154, 154),
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  height: 22.0,
                ),
                GestureDetector(
                    onTap: () {
                      if(formKey.currentState!.validate())
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CodeInputPage(code: controller.text,)),
                          );
                        }
                    },
                    child: Container(
                        height: 60,
                        width: 650, // استخدام كل المساحة الأفقية المتاحة
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 20, 120, 226), // لون الخلفية
                          borderRadius:
                              BorderRadius.circular(30.0), // زوايا مستديرة
                        ),
                        child: Center(
                          child: Text(
                            'تأكيد',
                            style: TextStyle(
                              fontSize: 24.0, // حجم النص
                              color: Colors.white,
                              fontFamily: 'cairo', // لون النص
                            ),
                          ),
                        ),
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
