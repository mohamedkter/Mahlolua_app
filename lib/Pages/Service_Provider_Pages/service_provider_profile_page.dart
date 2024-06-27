import 'package:flutter/material.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Pages/Service_Provider_Pages/service_provider_edit_profile.dart';
import 'package:mahloula/Pages/Service_Provider_Pages/service_provider_notifications.dart';
import 'package:mahloula/Pages/Service_Provider_Pages/service_provider_security_page.dart';
import 'package:mahloula/Pages/help_center_page.dart';
import 'package:mahloula/Pages/privacy_policy_page.dart';
import 'package:mahloula/Services/Data/cache_data.dart';
import 'package:mahloula/Widgets/logout_bottom_sheet.dart';

class ServiceProviderProfilePage extends StatelessWidget {
  const ServiceProviderProfilePage({super.key});

  void navigateToEditProfile(BuildContext context) {
    final employeeId = CacheData.getData(key: "employee_id");

    if (employeeId != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return EditServiceProviderProfile(employeeId: employeeId);
      }));
    } else {
      // معالجة الحالة عندما يكون employeeId فارغًا، مثل عرض رسالة خطأ
      print('Error: employeeId is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  const Text(
                    "الملف الشخصي",
                    style: TextStyle(
                        fontFamily: 'cairo',
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: MainColor,
                        borderRadius: BorderRadius.circular(10)),
                    width: 30,
                    height: 30,
                  )
                ],
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),

            /////////// Profile Image Section ////////////////

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 140,
                  height: 140,
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 135,
                            height: 135,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(75),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        "$PartImagePath${CacheData.getData(key: "image")}"))),
                          ),
                        ],
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                              onPressed: () {
                                navigateToEditProfile(context);
                              },
                              icon: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      color: MainColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ))))
                    ],
                  ),
                )
              ],
            ),

            ////////// Name and Email Section /////////////////
            Text(
              "${CacheData.getData(key: "name")}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontFamily: 'cairo',
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "${CacheData.getData(key: "email")}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontFamily: 'cairo',
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              indent: 20,
              endIndent: 20,
            ),

            ///////// Options Section//////////////
            OptionCard(
              OptionCardIcon: const Icon(
                Icons.person_outline_rounded,
                size: 32,
              ),
              OptionCardtext: "تعديل الملف",
              OptionFunction: () {
                navigateToEditProfile(context);
              },
            ),
            OptionCard(
              OptionCardIcon: const Icon(
                Icons.notifications_outlined,
                size: 32,
              ),
              OptionCardtext: "الاشعارات",
              OptionFunction: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return NotificationSettingsScreen();
                }));
              },
            ),
             OptionCard(
              OptionCardIcon: const Icon(
                Icons.rate_review_rounded,
                size: 32,
              ),
              OptionCardtext: "تقيمات العملاء",
              OptionFunction: () {},
            ),
            OptionCard(
              OptionCardIcon:const Icon(
                Icons.preview_rounded,
                size: 32,
              ),
              OptionCardtext: "الأعمال السابقة",
              OptionFunction: () {},
            ),
            OptionCard(
              OptionCardIcon:const Icon(
                Icons.security_rounded,
                size: 32,
              ),
              OptionCardtext: "الامان",
              OptionFunction: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return SecuritySettingsScreen();
                }));
              },
            ), OptionCard(
              OptionCardIcon:const Icon(
                Icons.lock_person,
                size: 32,
              ),
              OptionCardtext: "سياسة الخصوصية",
              OptionFunction: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
                );
              },
            ),
            OptionCard(
              OptionCardIcon:const Icon(
                Icons.help_center_rounded,
                size: 32,
              ),
              OptionCardtext: "مركز المساعدة",
              OptionFunction: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpCenterPage()),
                );
              },
            ),

////////////Log out Button //////////

            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: (){
                       showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return const LogoutBottomSheet();
                              });
                    },
                    child: Container(
                      width: 150,
                      height: 50,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "تسجيل خروج",
                            style: TextStyle(
                                color: Colors.red,
                                fontFamily: 'cairo',
                                fontSize: 15.0,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(width: 10,),
                          Icon(
                            Icons.logout_rounded,
                            color: Colors.red,
                            size: 35,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OptionCard extends StatelessWidget {
  final Icon OptionCardIcon;
  final String OptionCardtext;
  final VoidCallback OptionFunction;
  const OptionCard({
    super.key,
    required this.OptionCardIcon,
    required this.OptionCardtext,
    required this.OptionFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: ListTile(
          onTap: OptionFunction,
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 18,
          ),
          leading: OptionCardIcon,
          title: Text(
            OptionCardtext,
            style: const TextStyle(
                fontFamily: 'cairo',
                fontSize: 15.0,
                fontWeight: FontWeight.w700),
          ),
        ));
  }
}
