import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/modules/counter/cubit/cubit.dart';
import 'package:udemy_flutter/modules/counter/cubit/states.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
                title: Text('Counter')
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed: (){CounterCubit.get(context).decrease();}, child: Text('MINUS')),
                  SizedBox(width: 10.0),
                  Text(
                    '${CounterCubit.get(context).counter}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.0),
                  ),
                  SizedBox(width: 10.0),
                  TextButton(onPressed: (){CounterCubit.get(context).increase();}, child: Text('PLUS')),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
