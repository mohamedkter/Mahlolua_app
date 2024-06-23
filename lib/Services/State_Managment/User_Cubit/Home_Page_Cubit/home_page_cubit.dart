import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahloula/Models/service_model.dart';
import 'package:mahloula/Services/Api/get_methods.dart';
import 'package:mahloula/Services/State_Managment/User_Cubit/Home_Page_Cubit/home_page_status.dart';

class HomePageCubit extends Cubit<HomePageStatus> {
  HomePageCubit() : super(InitialState());
  List<Service> services = [];

  Future<void> getPageContent() async {
    emit(LoadingStatus());
    dynamic response = await GetMethods.getAllServices();
    print(response);
    if (response != null) {
      List<dynamic> responseServices = response["services"];
      services = responseServices.map((e) => Service.fromJson(e)).toList();
      emit(SuccessStatus());
    }else{
      emit(ErrorStatus());
    }
  }
}
