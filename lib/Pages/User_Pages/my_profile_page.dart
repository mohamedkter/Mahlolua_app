import 'package:flutter/material.dart';
import 'package:mahloula/Pages/User_Pages/home_page.dart';
import 'package:mahloula/Pages/User_Pages/login_page.dart';
import 'package:mahloula/Pages/notifications_page.dart';
import 'package:mahloula/Pages/User_Pages/reservation_page.dart';
import '../../Constants/Color_Constants.dart';



class MyProfilePage extends StatefulWidget {
  MyProfilePage({Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<MyProfilePage> {
  TextEditingController nameController = TextEditingController();

  TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'الحساب',
          style: TextStyle(fontSize: 27.0, color: Colors.white,fontFamily: 'cairo'),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
           // Navigator.push(context, MaterialPageRoute(builder: (context){return HomePage(name: '',);}));
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.white],
            stops: [0.0, 1.0],
          ),),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Spacer(flex: 2),
              Container(
                height: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: MainColor,
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0,right: 13),
                          child: Container(
                            height: 70,
                            width: 60,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(16)),
                            child: Image.asset('assets/photo/277574721_449206976977953_1149251544066168050_n.jpg',fit: BoxFit.cover,),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (nameController.text.isEmpty)? 'Mohamed' : nameController.text,
                              style: TextStyle(
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                            ),
                            Text(
                              (numberController.text.isEmpty)? '+201013262405' : numberController.text,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey.shade400
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: ()
                        {
                          showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.black,
                              builder: (context){
                                return Container(
                                  child: Column(
                                    children: [
                                      CustomTextFormField(
                                          label: 'Change Name',
                                          obscure: false,
                                          controller: nameController
                                      ),
                                      CustomTextFormField(
                                          label: 'Change Number',
                                          obscure: false,
                                          controller: numberController
                                      ),
                                      TextButton(
                                          onPressed: ()
                                          {
                                            changeName(nameController.text);
                                            changeNumber(numberController.text);
                                          },
                                          child: Text('Confirm',style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 21.0
                                          ),)
                                      )
                                    ],
                                  ),
                                );
                              }
                          );
                        },
                        icon: Icon(Icons.edit,color: Colors.white,size: 30,)
                    )
                  ],
                ),
              ),
              Spacer(flex: 1),
              CustomProfileContainer(
                fun: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context){return ReservationPage();}));
                },
                name: 'الحجوزات',
                icon: Icon(Icons.card_travel,color: Colors.white,),
              ),
              Spacer(flex: 1),
              CustomProfileContainer(
                fun: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context){return NotificationsPage();}));
                },
                name: 'الاشعارات',
                icon: Icon(Icons.notifications_none,color: Colors.white,),
              ),
              Spacer(flex: 1),
              CustomProfileContainer(
                fun: ()
                {

                },
                name: 'العنوان',
                icon: Icon(Icons.home_work_outlined,color: Colors.white,),
              ),
              Spacer(flex: 2),
              Directionality(
                textDirection: TextDirection.rtl,
                child: InkWell(
                    onTap: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context){return LoginPage();}));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.exit_to_app,color: Colors.black,size: 30,),
                        SizedBox(width: 8,),
                        Text(
                          'خروج',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'cairo',
                              fontSize: 23.0
                          ),
                        )
                      ],
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  
  
  
  String changeName(String? name)
  {
    if(name != null)
    {
      setState(() {
        nameController.text = name;
      });
      return nameController.text;
    }
    else
    {
      setState(() {
        nameController.text = 'Mohamed Ali';
      });
      return nameController.text;
    }
  }

  String changeNumber(String? name)
  {
    if(name != null)
    {
      //setState(() {
      numberController.text = name;
      // });
      return numberController.text;
    }
    else
    {
      //setState(() {
      numberController.text = '+20 1013262405';
      //});
      return numberController.text;
    }
  }
}

class CustomProfileContainer extends StatelessWidget {
  const CustomProfileContainer({
    required this.name, required this.fun, required this.icon, this.color});
  final String name;
  final VoidCallback fun;
  final Icon icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: InkWell(
        onTap: fun,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: MainColor,
              borderRadius: BorderRadius.circular(16)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 16.0,right: 13),
                      child: icon
                  ),
                  Text(
                    name,
                    style: TextStyle(
                        fontSize: 19.0,
                        color: Colors.white,
                      fontFamily: 'cairo'
                    ),
                  ),
                ],
              ),
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.arrow_forward_ios,color: Colors.white,size: 25,)
              )
            ],
          ),
        ),
      ),
    );
  }
}


class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.label,
    required this.obscure,
    @required this.preIcon,
    @required this.posIcon,
    required this.controller,
  }) ;
  final String label;
  final bool obscure;
  final Icon? preIcon;
  final IconButton? posIcon;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            style: TextStyle(
                color: Colors.white
            ),
            obscureText: obscure,
            validator: (data) {
              if (data!.isEmpty) {
                return 'Field is required';
              }
            },
            controller: controller,
            decoration: InputDecoration(
                prefixIcon: preIcon,
                suffixIcon: posIcon,
                labelText: label,
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(7)),
                border: OutlineInputBorder()),
          ),
        ],
      ),
    );
  }
}
