
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahloula/Models/feedback_model.dart';
import 'package:mahloula/Services/Api/get_methods.dart';
import 'package:mahloula/Services/Api/post_methods.dart';
import 'package:mahloula/Services/State_Managment/FeedBack_Cubit/feedback_states.dart';

class FeedbackCubit extends Cubit<FeedbackStates> {
FeedbackCubit() : super(InitialState());
  List<Feedback> feedBacks=[];
  Future<void> getServiceProviderByServiceId(int? serviceProviderId) async {
    emit(FeedbackLoadingState());
  serviceProviderId?? emit(FeedbackLoadingState());
    dynamic response=await GetMethods.getFeedbacksByServiceProviderId(serviceProviderId!);
    if (response!=null) {
       List<dynamic> allSFeedBacks=response;
       feedBacks=allSFeedBacks.map((e) => Feedback.fromJson(e)).toList();
       emit(FeedbackSuccessState());
    }else{
      emit(FeedbackErrorState());
    }
  }
  
    Future<void> makeFeedback(
      {  required int empId, required String Comment, required int rating, required int orderId}) async {
      emit(FeedbackLoadingState());
      dynamic respo =
          await PostMethods.makeFeedback(empId, Comment, rating, orderId);
      if (respo != null) {
        emit(FeedbackSuccessState());
      } else {
        emit(FeedbackErrorState());
      }
    }
}
