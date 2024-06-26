import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahloula/Constants/Color_Constants.dart';
import 'package:mahloula/Pages/Service_Provider_Pages/service_provider_main_page.dart';
import 'package:mahloula/Pages/User_Pages/home_page.dart';
import 'package:mahloula/Pages/Auth_Pages/login_page.dart';
import 'package:mahloula/Services/Data/cache_data.dart';
import 'package:mahloula/Services/State_Managment/FeedBack_Cubit/feedback_cubit.dart';
import 'package:mahloula/Services/State_Managment/Search_Cubit/search_cubit.dart';
import 'package:mahloula/Services/State_Managment/Service%20_Provider_Cubit/Credentials_Cubit/credentials_cubit.dart';
import 'package:mahloula/Services/State_Managment/Alll_Reservation_Page_Cubit/all_reserviation_page_cubit.dart';
import 'package:mahloula/Services/State_Managment/User_Cubit/Home_Page_Cubit/home_page_cubit.dart';
import 'package:mahloula/Services/State_Managment/User_Cubit/Specific_Service_Page_Cubit/specific_service_page_cubit.dart';
import 'Pages/User_Pages/welcome_page_one.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheData.cacheInitialization();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomePageCubit(),
        ),
        BlocProvider(create: (context) => CredentialsCubit()),
        BlocProvider(create: (context) => SpecificServicePageCubit()),
        BlocProvider(create: (context) => AllReservitionPageCubit()),
        BlocProvider(create: (context)=>FeedbackCubit()),
        BlocProvider(create: (context)=>SearchCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: MainColor,
          inputDecorationTheme: const InputDecorationTheme(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MainColor, width: 2.0),
            ),
          ),
        ),
        home: CacheData.getData(key: "token") == null
            ? const LoginPage()
            : CacheData.getData(key: "employee_id") == null
                ? HomePage(name: "${CacheData.getData(key: "name")}")
                : ServiceProviderMainPage(
                    name: "${CacheData.getData(key: "name")}"),
      ),
    );
  }
}
