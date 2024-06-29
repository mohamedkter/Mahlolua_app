import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahloula/Services/State_Managment/state.dart';
import 'package:sqflite/sqflite.dart';

class Cubite extends Cubit<Statees>{
  Cubite() : super(initialState());

  static Cubite get(context) => BlocProvider.of(context);

  List<Map<dynamic,dynamic>> info = [];
  Database? database;
  // required this.ServiceProviderName,
  // required this.Price,
  // required this.rate,
  // required this.NumberResidents,
  // required this.ProvidedService,
  void createDatabase() {
    openDatabase('bookMark', version: 1, onCreate: (database, version) async {
      print('database created');
      await database
          .execute(
          'CREATE TABLE BookMarks(id int,ServiceProviderName TEXT,image TEXT,Price TEXT,rate double,NumberResidents int,ProvidedService TEXT)')
          .then((value) {
        print('table created');
      }).catchError((onError) {
        print('Error is ${onError.toString()}');
      });
    }, onOpen: (database) {
      print('database opened');
    }).then((value) {
      database = value;
      print(value);
      //getDataFromDatabase(database);
      emit(createState());
    });
  }


  Future insertToDatabase({
    required int id,
    required String ServiceProviderName,
    required String image,
    required String Price,
    required double rate,
    required int NumberResidents,
    required String ProvidedService,
  }) async {
    await database?.transaction((txn) {
      txn
          .rawInsert(
          'INSERT INTO BookMarks(id,ServiceProviderName,image,Price,rate,NumberResidents,ProvidedService)'
              ' VALUES("$id","$ServiceProviderName","$image","$Price","$rate","$NumberResidents","$ProvidedService")')
          .then((value) {
        print('$value inserted successfully');
        //info.add(value);
        getDataFromDatabase(database);
        emit(insertState());
      }).catchError((onError) {
        print('Error in inserting values ${onError.toString()}');
      });
      return Future(() {});
    });
  }


  void getDataFromDatabase(database) {
    database!.rawQuery('SELECT * FROM BookMarks').then((value) {
      value.forEach((element)
      {
        info.add(element);
        print(element);
      });

      emit(getState());
    });
  }


  void deleteFromDatabase({
    required int id
  })
  {
    database!.rawDelete(
        'DELETE FROM BookMarks WHERE id = ?',
        [id]
    ).then((value) {
      getDataFromDatabase(database);
      print('deleted successfully');
      emit(deleteState());
    });
  }
}