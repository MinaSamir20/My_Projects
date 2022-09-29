import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';

import '../../modules/archived_tasks/archived_tasks_screen.dart';
import '../../modules/done_tasks/done_tasks_screen.dart';
import '../../modules/new_tasks/new_tasks.dart';

class TodoAppCubit extends Cubit<TodoAppStates> {
  TodoAppCubit() : super(TodoInitState());

  static TodoAppCubit get(BuildContext context) => BlocProvider.of(context);

  var currentIndex = 0;




  List<Widget> screens = [
    const NewTasksScreen(),
    const DoneTasksSrceen(),
    const ArchivedTasksScreen(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeNavBarIndex());
  }

  //DataBase
  var database;
  List<Map> tasks = [];

  //Create DataBase
  void createDataBase() {
    database = openDatabase('todo.db', version: 1, onCreate: (db, version) {
      print('Database Created');
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY kEY, title TEXT, date TEXT, time TEXT, status TEXT)')
          .then((value) {
        print('table created');
      }).catchError((error) {
        print('Error When Creating Table \n${error.toString()}');
      });
    }, onOpen: (database) {
      getDataFromDataBase(database);
      print('Database Opened');
    }).then((value) {
      database.value;
      emit(CreateDatabaseState());
    });
  }

  //Insert Data From DataBase
  insertToDataBase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks (title, date, time, status) VALUES ("$title", "$date", "$time", "new")')
          .then((value) {
        print('$value inserted successfully');
        emit(InsertDatabaseState());
        getDataFromDataBase(database).then((value) {
          tasks = value;
          print(tasks);
          emit(GetDatabaseState());
        });
      }).catchError((e) {
        print('Error When Inserting New Record \n${e.toString()}');
      });
      return null;
    });
  }

  //Get Data From DataBase
  Future<List<Map>> getDataFromDataBase(db) {
    return db.rawQuery('SELECT * FROM tasks');
  }

  //=========================\\
  //=======BottomSheet=======\\
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(ChangeBottomSheetState());
  }
}
