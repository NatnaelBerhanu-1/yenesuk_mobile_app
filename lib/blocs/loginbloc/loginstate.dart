import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LoginState extends Equatable{
  @override
  List<Object> get props => [];
}
class IdleState extends LoginState{}
class VerifyingOTPState extends LoginState{}
class OTPSentState extends LoginState{}
class OTPVerifiedState extends LoginState{
  SharedPreferences sharedPreferences;
  OTPVerifiedState({@required this.sharedPreferences}):assert(sharedPreferences!=null);
}
class VerificationFailedState extends LoginState{}