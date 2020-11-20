import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class SendOTPEvent extends LoginEvent{
  final String phoneNumber;
  SendOTPEvent({@required this.phoneNumber}):assert(phoneNumber!=null);

  @override
  List<Object> get props => [phoneNumber];
}

class VerifyOTPEvent extends LoginEvent{
  final String otp, phoneNumber;
  VerifyOTPEvent({@required this.otp, @required this.phoneNumber}):assert(otp!=null&&phoneNumber!=null);

  @override
  List<Object> get props => [otp];
}