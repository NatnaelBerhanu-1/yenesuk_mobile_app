import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yenesuk/models/user.dart';

abstract class CreateAccountState extends Equatable{
  @override
  List<Object> get props => [];
}

class IdleState extends CreateAccountState{}

class BusyState extends CreateAccountState{}

class SuccessState extends CreateAccountState{
  final User user;
  final SharedPreferences sharedPreferences;
  SuccessState({@required this.user, @required this.sharedPreferences}):assert(user!=null&&sharedPreferences!=null);
}

class FailedState extends CreateAccountState{}