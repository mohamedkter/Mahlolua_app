import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahloula/Models/service_model.dart';
import 'package:mahloula/Models/sponsor_model.dart';
import 'package:mahloula/Services/Api/get_methods.dart';
import 'package:mahloula/Services/State_Managment/User_Cubit/Home_Page_Cubit/home_page_status.dart';

class HomePageCubit extends Cubit<HomePageStatus> {
  HomePageCubit() : super(InitialState());
  List<Service> services = [];
  List<Sponsor> sponsors=[];

  Future<void> getPageContent() async {
    emit(LoadingStatus());
    dynamic responseOne = await GetMethods.getAllServices();
    dynamic responseTwo=await GetMethods.getSponsors();
    if (responseOne != null&&responseTwo!=null) {
      List<dynamic> responseServices = responseOne["services"];
      services = responseServices.map((e) => Service.fromJson(e)).toList();
       List<dynamic> responseSponsors=responseTwo;
      sponsors=responseSponsors.map((e) =>Sponsor.fromJson(e),).toList(); 
      emit(SuccessStatus());
    }else{
      emit(ErrorStatus());
    }
  }
}
