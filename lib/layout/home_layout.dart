import 'package:flutter/material.dart';
import 'package:udemy_flutter/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:udemy_flutter/modules/done_tasks/done_tasks_screen.dart';
import 'package:udemy_flutter/modules/new_tasks/new_tasks.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  var currentIndex = 0;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksSrceen(),
    ArchivedTasksScreen(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  var db;
  var scafoldKey = GlobalKey<ScaffoldState>();
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    createDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafoldKey,
      appBar: AppBar(
        title: Text(titles[currentIndex]),
      ),
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        child: Icon(fabIcon),
        onPressed: () {
          if (isBottomSheetShown) {
            Navigator.pop(context);
            isBottomSheetShown = false;
            setState(() {
              fabIcon = Icons.edit;
            });
          } else {
            scafoldKey.currentState?.showBottomSheet((context) => Container(
                  color: Colors.grey[100],
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Task TextField
                      defaultFormField(
                        controller: titleController,
                        type: TextInputType.text,
                        label: 'Task Title',
                        prefix: Icons.title,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'title must not be empty';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      //Time
                      defaultFormField(
                        controller: timeController,
                        type: TextInputType.datetime,
                        label: 'Task Time',
                        prefix: Icons.watch_later_rounded,
                        onTap: () {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          ).then((value) {
                            print(value.toString());
                          }).catchError((e) {
                            print('Error is ${e.toString()}');
                          });
                        },
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'time must not be empty';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ));
            isBottomSheetShown = true;
            setState(() {
              fabIcon = Icons.add;
            });
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Done',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive),
            label: 'Archive',
          ),
        ],
      ),
    );
  }

  Future<String> getName() async {
    return 'Mina Samir';
  }

  void createDB() async {
    db = await openDatabase('todo.db', version: 1, onCreate: (db, version) {
      print('Database Created');
      db
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY kEY, title TEXT, date TEXT, time TEXT, status TEXT)')
          .then((value) {
        print('table created');
      }).catchError((error) {
        print('Error When Creating Table \n${error.toString()}');
      });
    }, onOpen: (db) {
      print('Database Opened');
    });
  }

  void insertToDB() async {
    await db.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks (title, date, time, status) VALUES ("first Task", "02222", "891", "new")')
          .then((value) {
        print('$value inserted successfully');
      }).catchError((e) {
        print('Error When Inserting New Record \n${e.toString()}');
      });
    });
  }

  void updateDB() {
    //
  }

  void delteDB() {
    //
  }
}
