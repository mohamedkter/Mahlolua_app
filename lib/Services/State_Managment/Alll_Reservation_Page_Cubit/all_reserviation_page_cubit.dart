import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahloula/Services/Api/get_methods.dart';
import 'package:mahloula/Services/Api/post_methods.dart';
import 'package:mahloula/Services/Data/cache_data.dart';
import 'package:mahloula/Services/State_Managment/Alll_Reservation_Page_Cubit/all_reserviation_page_status.dart';
import 'package:mahloula/models/reservation_model.dart';

class AllReservitionPageCubit extends  Cubit<AllReservationPageStatus>{
  AllReservitionPageCubit(): super(InitialState());
  List<Reservation> data =[];
  List<Reservation> employeeOrders=[];
  Future<void> getAllReservationForUser(int userId)async {
    emit(AllReservationPageLoadingStatus());
   data = await GetMethods.getUserOrders(userId);
   emit(AllReservationPageSuccessStatus());
  }
  Future<void> changeOrderStatusForUser(int orderId,String newStatus)async {
    emit(AllReservationPageLoadingStatus());
  await  PostMethods.changeOrderStatus(orderId, newStatus);
  await getAllReservationForUser(CacheData.getData(key: "userId"));
  emit(AllReservationPageSuccessStatus());
    
  }

   Future<void> getAllReservationForServiceProvider()async {
    emit(AllReservationPageLoadingStatus());
   employeeOrders = (await GetMethods.getEmployeeOrders(CacheData.getData(key: "employee_id"))).cast<Reservation>();
   print("Doneeeeeeeeeeeeeeeeeeeee");
   emit(AllReservationPageSuccessStatus());
  }
  Future<void> changeOrderStatusForServiceProvider(int orderId,String newStatus)async {
    emit(AllReservationPageLoadingStatus());
  await  PostMethods.changeOrderStatus(orderId, newStatus);
  await getAllReservationForServiceProvider();
  emit(AllReservationPageSuccessStatus());
    
  }
}