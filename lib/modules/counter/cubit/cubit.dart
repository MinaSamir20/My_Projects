import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/modules/counter/cubit/states.dart';

class CounterCubit extends Cubit<CounterStates> {
  CounterCubit() : super(InitCounterState());

  static CounterCubit get (context) => BlocProvider.of(context);


  int counter = 0;

  void increase(){
    counter++;
    emit(StateOne());
  }

  void decrease(){
    counter--;
    emit(StateTwo());
  }
}