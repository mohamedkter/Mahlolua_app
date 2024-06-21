import 'package:flutter/material.dart';
import 'package:mahloula/Pages/User_Pages/home_page.dart';



class CreateProfilePage extends StatefulWidget {
  @override
  _CreateProfilePageState createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _calendarController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  bool _isImageSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('انشاء ملف شخصى',style: TextStyle(color: Colors.black,fontFamily: 'cairo',),),
        backgroundColor: Colors.white,
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _selectImage,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    child: _isImageSelected
                        ? ClipOval(
                            child: Image.network(
                              'https://example.com/your_image_url.jpg',
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.white,
                          ),
                  ),
                ),
                const SizedBox(height: 16),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                      textDirection: TextDirection.rtl,
                      controller: _usernameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'ادخل الاسم';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'الاسم',
                          prefixIcon: Icon(Icons.person),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 174, 154, 154),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(30),
                          )),
                    ),
                ),
                SizedBox(height: 8),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                      textDirection: TextDirection.rtl,
                      controller: _jobController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'ادخل الوظيفه';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'الوظيفه',
                           prefixIcon: Icon(Icons.work),
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
                SizedBox(height: 8),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                      textDirection: TextDirection.rtl,
                      controller: _emailController,
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
                SizedBox(height: 8),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    textDirection: TextDirection.rtl,
                    controller: _calendarController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'ادخل تاريخ الميلاد';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'تاريخ الميلاد',
                        prefixIcon: Icon(Icons.calendar_today),
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
                SizedBox(height: 8),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                      textDirection: TextDirection.rtl,
                      controller: _phoneController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'ادخل رقم الهاتف';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'رقم الهاتف',
                          prefixIcon: Icon(Icons.phone),
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
                const SizedBox(height: 8),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                      textDirection: TextDirection.rtl,
                      controller: _addressController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'ادخل العنوان';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'العنوان',
                          prefixIcon: Icon(Icons.location_on),
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
                SizedBox(height: 24),
                GestureDetector(
                        onTap:()
                        {
                          if(formKey.currentState!.validate()){
                             Navigator.push(context, MaterialPageRoute(builder: (context){
                               return HomePage(name: _usernameController.text,);
                             }));
                          }
                        },
                  child: Container(
                        height: 60,
                        width: 650, // استخدام كل المساحة الأفقية المتاحة
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 20, 120, 226), // لون الخلفية
                          borderRadius: BorderRadius.circular(30.0), // زوايا مستديرة
                        ),
                        child: Center(
                          child: Text(
                            'متابعه',
                            style: TextStyle(
                              fontSize: 24.0, // حجم النص
                              color: Colors.white,
                              fontFamily: 'cairo', // لون النص
                            ),
                          ),
                        ),
                      )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _selectImage() {
    // يمكنك هنا تنفيذ رمز لتحميل الصورة من المعرض أو التقاطها باستخدام الكاميرا
    // في هذا المثال، سنفترض أن الصورة تمثلت برمز الشخص إذا تم اختيارها
    setState(() {
      _isImageSelected = true;
    });
  }

//   void _submitProfile() {
//     // يمكنك هنا تنفيذ رمز لإرسال بيانات الملف الشخصي إلى خادم أو مكان تخزين البيانات
//     String username = _usernameController.text;
//     String job = _jobController.text;
//     String email = _emailController.text;
//     String calendar = _calendarController.text;
//     String phone = _phoneController.text;
//     String address = _addressController.text;
//
//     // يمكنك إضافة المزيد من المنطق هنا حسب احتياجات التطبيق الخاص بك
//
//     // إظهار رسالة تأكيد أو التوجيه إلى الصفحة التالية
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Profile Created'),
//           content: Text('Profile for $username created successfully!',style: TextStyle(fontFamily: 'cairo',),),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
 }