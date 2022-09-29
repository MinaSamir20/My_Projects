// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    //Local Variable
    var scaffoldKey = GlobalKey<ScaffoldState>();
    var formKey = GlobalKey<FormState>();
    var titleController = TextEditingController();
    var timeController = TextEditingController();
    var dateController = TextEditingController();

    return BlocProvider(
      create: (context) => TodoAppCubit()..createDataBase(),
      child: BlocConsumer<TodoAppCubit, TodoAppStates>(
        listener: (context, state) {
          if(state is InsertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          //Create Cubit Variable to easily access
          TodoAppCubit cubit = TodoAppCubit.get(context);

          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            body: /*cubit.tasks.isEmpty
                ? const Center(child: CircularProgressIndicator())
                :*/ cubit.screens[cubit.currentIndex],
            floatingActionButton: FloatingActionButton(
              child: Icon(cubit.fabIcon),
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text,
                    );
                  }
                } else {
                  scaffoldKey.currentState
                      ?.showBottomSheet(
                        (context) => Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
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
                                const SizedBox(height: 15),
                                //Time Picker
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
                                      timeController.text =
                                          value!.format(context);
                                      print(value.format(context));
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
                                const SizedBox(height: 15),
                                //Date Picker
                                defaultFormField(
                                  controller: dateController,
                                  type: TextInputType.datetime,
                                  label: 'Task Date',
                                  prefix: Icons.calendar_month_outlined,
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2100),
                                    ).then((value) {
                                      dateController.text =
                                          DateFormat.yMMMd().format(value!);
                                      print(DateFormat.yMMMd().format(value));
                                    }).catchError((e) {
                                      print('Error is ${e.toString()}');
                                    });
                                  },
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Date must not be empty';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        elevation: 20.0,
                      )
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                        isShow: false, icon: Icons.edit);
                  });
                  cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
                }
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: const [
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
        },
      ),
    );
  }

  void updateDB() {
    //
  }

  void deleteDB() {
    //
  }
}
