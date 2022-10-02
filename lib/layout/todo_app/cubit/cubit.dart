// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy_flutter/layout/todo_app/cubit/states.dart';

import '../../../modules/archived_tasks/archived_tasks_screen.dart';
import '../../../modules/done_tasks/done_tasks_screen.dart';
import '../../../modules/new_tasks/new_tasks.dart';

class TodoAppCubit extends Cubit<TodoAppStates> {
  TodoAppCubit() : super(TodoInitState());

  static TodoAppCubit get(BuildContext context) => BlocProvider.of(context);

  var currentIndex = 0;

  List<Widget> screens = [
    const NewTasksScreen(),
    const DoneTasksScreen(),
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
  Database? database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  //Create DataBase
  void createDataBase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('Database Created');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY kEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print('Database Opened');
      },
    ).then((value) {
      database = value;
      print(database);
      emit(CreateDatabaseState());
    });
  }

  //Insert Data From DataBase
  insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database?.transaction((txn) => txn
            .rawInsert(
          'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")',
        )
            .then((value) {
          print('$value inserted successfully');
          emit(InsertDatabaseState());
          getDataFromDatabase(database);
        }).catchError((error) {
          print('Error When Inserting New Record ${error.toString()}');
        }));
    return null;
  }

  //Get Data From DataBase
  void getDataFromDatabase(database) async {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

    emit(GetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach(
        (element) {
          if (element['status'] == 'new') {
            newTasks.add(element);
          } else if (element['status'] == 'done') {
            doneTasks.add(element);
          } else {
            archivedTasks.add(element);
          }
        },
      );
      emit(GetDatabaseState());
    });
  }

  //Update Data In DataBase
  void updateData({
    required String status,
    required int id,
  }) async {
    database?.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        [status, '$id']).then((value) {
      getDataFromDatabase(database);
      emit(UpdateDatabaseState());
    });
  }

  //Delete Data In DataBase
  void deleteData({
    required int id,
  }) async {
    database?.rawDelete('DELETE FROM tasks WHERE id = ?',
        ['$id']).then((value) {
      getDataFromDatabase(database);
      emit(DeleteDatabaseState());
    });
  }

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
