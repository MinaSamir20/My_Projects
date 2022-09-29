import 'package:flutter/material.dart';
import 'package:udemy_flutter/shared/cubit/cubit.dart';

import '../../shared/components/components.dart';

class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => buildTasksItem(TodoAppCubit.get(context).tasks[index]),
        separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(height: 1.0, color: Colors.grey[300]),
            ),
        itemCount: TodoAppCubit.get(context).tasks.length);
  }
}
