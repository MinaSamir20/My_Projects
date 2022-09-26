import 'package:flutter/material.dart';

class DoneTasksSrceen extends StatelessWidget {
  const DoneTasksSrceen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Done Tasks',
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
