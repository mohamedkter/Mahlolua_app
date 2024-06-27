import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahloula/Models/service_provider_model.dart';
import 'package:mahloula/Services/Api/get_methods.dart';
import 'package:mahloula/Services/Api/post_methods.dart';
import 'package:mahloula/Services/State_Managment/Search_Cubit/search_states.dart';

class SearchCubit extends Cubit<SearchState> {
SearchCubit() : super(InitialState());
  List<ServiceProvider> serviceProvider=[];
  Future<void> Search(String query) async {
    emit(SearchLoading());
    dynamic response=await PostMethods.SearchFunction(query);
    if (response!=null) {
       List<dynamic> allServiceProviders=response;
       serviceProvider=ServiceProvider.fromJsonArray(allServiceProviders);
       emit(SearchSuccess());
    }else{
      emit(SearchNotFound());
    }
  }
}