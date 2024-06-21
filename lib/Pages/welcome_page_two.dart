import 'package:flutter/material.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Pages/Auth_Pages/login_page.dart';
import 'package:mahloula/Pages/Auth_Pages/regester_page.dart';


class WelcomePageTwo extends StatelessWidget {
  const WelcomePageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تسجيل الدخول',style: TextStyle(fontFamily: 'cairo',), ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(
              flex: 3,
            ),
            Text(
              ' لنقم بتسجيلك',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w900,
                fontFamily: "cairo"
              ),
            ),
            SizedBox(height: 30),
            Socialimage(
              image: Image.asset("assets/photo/facebook.png"),
              text: Text(
                "اكمل بواسطه فيسبوك",style: TextStyle(fontFamily: "cairo"),
                textDirection: TextDirection.rtl,
              ),
            ),
            SizedBox(width: 10),
            Socialimage(
              image: Image.asset("assets/photo/google.png"),
              text: Text("اكمل بواسطه جوجل",style: TextStyle( fontFamily: 'cairo',),),
            ),
            SizedBox(width: 10),
            Socialimage(
              image: Image.asset("assets/photo/apple.png"),
              text: Text("اكمل بواسطه ابل",style: TextStyle( fontFamily: 'cairo',),),
            ),
            Spacer(
              flex: 1,
            ),
            GestureDetector(
                    onTap:() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
              },
              child: Container(
                    height: 60,
                    width: 650, 
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: MainColor, 
                      borderRadius: BorderRadius.circular(30.0), 
                    ),
                    child: Center(
                      child: Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                          fontSize: 24.0, 
                          color: Colors.white,
                          fontFamily: "cairo" 
                        ),
                      ),
                    ),
                  )
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                  child: Text(
                    'إنشاء حساب',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontFamily: "cairo"
                    ),
                  ),
                ),
                Text(
                  'ليس لديك حساب؟ ',style: TextStyle(fontFamily: "cairo"),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Socialimage extends StatelessWidget {
  final Image image;
  final Text text;

  Socialimage({required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Center(
        child: Container(
            height: 55,
            width: double.infinity,   
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.all(9.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 194, 204, 212), 
              borderRadius: BorderRadius.circular(10.0), 
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                text,
                SizedBox(
                  width: 23.0,
                ),
                image,
              ],
            )),
      ),
    );
  }
}
