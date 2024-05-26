import 'package:flutter/material.dart';
import 'package:mahloula/Pages/User_Pages/new_password_page.dart';




class CodeInputPage extends StatelessWidget {
  CodeInputPage({required this.code});
  final String code;
  GlobalKey<FormState> formKey = GlobalKey();
  final List<TextEditingController> _codeControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(
              flex: 2,
            ),
            Text('تم ارسال الرمز الى ${code}',style: TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'cairo'
            ),),
            Spacer(
              flex: 1,
            ),
            Form(
              key: formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                  (index) => Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      validator: (data)
                      {
                        if(data!.isEmpty)
                          {
                            return 'خطأ';
                          }
                      },
                      controller: _codeControllers[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 3) {
                          // Focus next TextField
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      decoration: InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Row(
               mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("ثانيه 53",
                  style: TextStyle(color:Colors.blue,fontSize: 14,fontWeight: FontWeight.bold),),
                Text(
                  ' اعاده ارسال الرمز فى',style: TextStyle(
                    fontSize: 14.0,
                    fontFamily: 'cairo'
                ),
                  ),

              ],
            ),
            Spacer(
              flex: 2,
            ),
            GestureDetector(
                        onTap: ()
                        {
                          if(formKey.currentState!.validate())
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePasswordPage()));
                            }
                        },
                        child: Container(
                          height: 60,
                          width: 650, // استخدام كل المساحة الأفقية المتاحة
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(
                                255, 20, 120, 226), // لون الخلفية
                            borderRadius:
                                BorderRadius.circular(30.0), // زوايا مستديرة
                          ),
                          child: Center(
                            child: Text(
                              ' تاكيد',
                              style: TextStyle(
                                fontSize: 24.0, // حجم النص
                                color: Colors.white, // لون النص
                              ),
                            ),
                          ),
                        )),
          ],
        ),
      ),
    );
  }
}
