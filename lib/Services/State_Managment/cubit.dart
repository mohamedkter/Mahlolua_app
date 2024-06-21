import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahloula/Services/State_Managment/state.dart';

class Cubite extends Cubit<States>{
  Cubite() : super(initialState());

  static Cubite get(context) => BlocProvider.of(context);



}