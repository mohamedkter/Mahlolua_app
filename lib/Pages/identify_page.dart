import 'package:flutter/material.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Pages/Service_Provider_Pages/service_provider_main_page.dart';
import 'package:mahloula/Pages/welcome_page_two.dart';

import 'Auth_Pages/regester_page.dart';


class IdentifyPage extends StatelessWidget {
  const IdentifyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double widthOfScreen=MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(flex: 1,),
            Text('!مرحبا',style:
            TextStyle(
                fontSize: 27.0,
                fontFamily: 'cairo',
                fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 3
              ),),
            Spacer(flex: 1,),
            Image.asset('assets/photo/download.png',width: 350,),
            Spacer(flex: 1,),
            Text(' انضمام',style:
            TextStyle(
                fontSize: 27.0,
                fontFamily: 'cairo',
                fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 15,),
            Directionality(
              textDirection: TextDirection.rtl,
              child: ElevatedButton(
                  onPressed: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context){return SignupPage(type: 'user',);}));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(MainColor)
                  ),
                  child: Container(
                    height: 60,
                    width: widthOfScreen/1.3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.supervised_user_circle_sharp,color: Colors.white,),
                        SizedBox(width: 10,),
                        Text(
                          'مستخدم',
                          style: TextStyle(
                              fontFamily: 'cairo',
                              fontSize: 21.0,
                              color: Colors.white
                          ),
                        )
                      ],
                    ),
                  )
              ),
            ),
            SizedBox(height: 10,),
            Directionality(
              textDirection: TextDirection.rtl,
              child: ElevatedButton(
                  onPressed: ()
                  {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignupPage(type: 'employee',)));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(MainColor)
                  ),
                  child: Container(
                    height: 60,
                    width: widthOfScreen/1.3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.build,color: Colors.white,),
                        SizedBox(width: 10,),
                        Text(
                          'مقدم خدمه',
                          style: TextStyle(
                              fontFamily: 'cairo',
                              fontSize: 21.0,
                              color: Colors.white
                          ),
                        )
                      ],
                    ),
                  )
              ),
            ),
            Spacer(flex: 1,),
          ],
        ),
      ),
    );
  }
}
