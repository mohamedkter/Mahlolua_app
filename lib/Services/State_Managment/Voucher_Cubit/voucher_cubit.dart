import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahloula/Models/voucher_model.dart';
import 'package:mahloula/Services/Api/get_methods.dart';
import 'package:mahloula/Services/State_Managment/Voucher_Cubit/voucher_states.dart';

class VoucherCubit extends Cubit<VoucherStates> {
  VoucherCubit() : super(InitialState());
  List<Voucher> allVoucher = [];
  List<Voucher> usedVoucher = [];
  List<Voucher> expiredVoucher = [];
  List<Voucher> availableVoucher = [];

  Future<void> getAllVoucher() async {
    emit(VoucherLoadingState());
    
    try {
      dynamic resp = await GetMethods.getAllVouchers();
      dynamic respTwo = await GetMethods.getUsedVoucher();
      
      if (resp != null) {
        List<dynamic> vouchers = resp;
        allVoucher = vouchers.map((e) => Voucher.fromJson(e)).toList();
        
        if (respTwo != null) {
          List<dynamic> usedVoucherRepo = respTwo;
          usedVoucher = usedVoucherRepo.map((e) => Voucher.fromJson(e)).toList();
        }
        
   
        expiredVoucher = allVoucher.where((voucher) {
          DateTime expiryDate = DateTime.parse(voucher.expiredAt);
          return expiryDate.isBefore(DateTime.now());
        }).toList();

        availableVoucher = allVoucher.where((voucher) =>
            !usedVoucher.any((used) => used.id == voucher.id) &&
            !expiredVoucher.any((expired) => expired.id == voucher.id)).toList();
        
        emit(VoucherSuccessState());
      } else {
        emit(VoucherErrorState());
      }
    } catch (e) {
      emit(VoucherErrorState());
    }
  }
}
