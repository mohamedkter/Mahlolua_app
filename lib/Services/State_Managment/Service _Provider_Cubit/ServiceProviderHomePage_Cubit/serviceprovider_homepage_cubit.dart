import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahloula/Services/Api/get_methods.dart';
import 'package:mahloula/Services/Api/post_methods.dart';
import 'package:mahloula/Services/Data/cache_data.dart';
import 'package:mahloula/Services/State_Managment/Service%20_Provider_Cubit/ServiceProviderHomePage_Cubit/serviceprovider_homepage_states.dart';
import 'package:mahloula/models/reservation_model.dart';

class ServiceProviderHomePageCubit
    extends Cubit<ServiceProviderHomePageStates> {
  ServiceProviderHomePageCubit() : super(InitialState());
  late int countOfOrders;
  List<Reservation> waitingOrders = [];
  late int total_rates;
  late String average_rating;
  late String status;
  Future<void> getWaitingOrders() async {
    emit(ServiceProviderHomePageLoading());
    final employeeId = CacheData.getData(key: "employee_id");
    getCountOfOrders();
    List<Reservation> orders = await GetMethods.getEmployeeOrders(employeeId);

    for (var ord in orders) {
      if (ord.status == "waiting") {
        waitingOrders.add(ord);
      }
    }
    dynamic resp = await GetMethods.getServiceProviderProfile(employeeId);
    if (resp != null) {
      total_rates = resp["total_rates"];
      average_rating = resp["average_rating"];
      status = resp["status"];
      emit(ServiceProviderHomePageSuccess());
    } else {
      emit(ServiceProviderHomePageEmpty());
    }
  }

  Future<void> getCountOfOrders() async {
    countOfOrders =
        await GetMethods.getCountOrders(CacheData.getData(key: "employee_id"));
  }

  Future<void> changeServiceProviderState(String status) async {
    dynamic resp = await PostMethods.changeServiceProviderId(status);
    if (resp != null) {
      getWaitingOrders();
      CacheData.setData(key: "employee_status", value: "$status");

      emit(ServiceProviderHomePageSuccess());
    } else {
      emit(ServiceProviderHomePageEmpty());
    }
  }
}
