import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahloula/Models/service_provider_model.dart';
import 'package:mahloula/Services/Api/get_methods.dart';
import 'package:mahloula/Services/State_Managment/User_Cubit/Specific_Service_Page_Cubit/specific_service_page_status.dart';

class SpecificServicePageCubit extends Cubit<SpecificServicePageState> {
SpecificServicePageCubit() : super(InitialState());
  List<ServiceProvider> serviceProvider=[];
  Future<void> getServiceProviderByServiceId(int serviceId) async {
    emit(ServicesProviderLoadingStatus());
    dynamic response=await GetMethods.getAllEmployeeInSpecificService(serviceId);
    if (response!=null) {
       List<dynamic> allServiceProviders=response;
       serviceProvider=allServiceProviders.map((e) => ServiceProvider.fromJson(e)).toList();
       emit(ServicesProviderSuccessStatus());
    }else{
      emit(ServiceProviderErrorStatus());
    }
  }
}
