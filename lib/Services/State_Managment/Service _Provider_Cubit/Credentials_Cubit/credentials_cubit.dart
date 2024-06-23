
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahloula/Models/service_model.dart';
import 'package:mahloula/Services/Api/get_methods.dart';
import 'package:mahloula/Services/State_Managment/Service%20_Provider_Cubit/Credentials_Cubit/credentials_status.dart';

class CredentialsCubit extends Cubit<CredentialsStatus> {
  CredentialsCubit() : super(InitialState());
  List<Service> services = [];
  Future<void> getAllServices() async {
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
