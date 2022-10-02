import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/news_app/cubit/state.dart';

class AppNewsCubit extends Cubit<AppNewsState>{
  AppNewsCubit() : super(AppNewsInitState());

  static AppNewsCubit get(BuildContext context) => BlocProvider.of(context);
}