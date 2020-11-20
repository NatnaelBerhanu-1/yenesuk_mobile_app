import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yenesuk/models/initdata.dart';

class InitState extends Equatable{
  @override
  List<Object> get props => [];
}

class FetchingState extends InitState{}
class FetchedState extends InitState{
  final InitData initData;
  final SharedPreferences sharedPreferences;
  FetchedState({@required this.initData, @required this.sharedPreferences}):assert(initData!=null&&sharedPreferences!=null);
}
class ErrorState extends InitState{}