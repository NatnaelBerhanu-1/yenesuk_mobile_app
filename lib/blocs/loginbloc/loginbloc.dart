import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yenesuk/blocs/loginbloc/userrepo.dart';
import 'package:yenesuk/models/user.dart';
import 'loginstate.dart';
import 'loginevent.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{
  FirebaseAuth auth = FirebaseAuth.instance;
  String _verificationId;
  UserRepository userRepository;
  SharedPreferences sharedPreferences;
  LoginBloc({@required this.userRepository,@required this.sharedPreferences}):assert(userRepository!=null && sharedPreferences!=null),super(IdleState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    try{
      if(event is SendOTPEvent){
        yield IdleState();
        print('send otp event');
        await auth.verifyPhoneNumber(
            phoneNumber: event.phoneNumber,
            timeout: Duration(seconds: 60),
            verificationCompleted: (AuthCredential credential){
              print('verificationCompleted');
              // auth.signInWithCredential(credential).then((AuthResult result){
              //   // TODO: login the user here and save instance
              //
              // }).catchError((error){
              //   print('authentication failed');
              //   print(error);
              //   throw Exception('verification failed');
              // });
            },
            verificationFailed: (AuthException authException){
              throw Exception('Verification Failed');
            },
            codeSent: (String verificationId, [int forceResendingToken]){
              print('code sent');
              _verificationId = verificationId;
            },
            codeAutoRetrievalTimeout: (String verificationId){
              _verificationId = verificationId;
            }
        );
        yield OTPSentState();
      }
      if(event is VerifyOTPEvent){
        yield VerifyingOTPState();
        var credential = PhoneAuthProvider.getCredential(verificationId: _verificationId, smsCode: event.otp);
        await auth.signInWithCredential(credential).then((AuthResult result){
          print('authenticated');
        }).catchError((error){
          print('authentication failed');
          print(error);
          throw Exception('verification failed');
        });
        User _user = new User();
        _user.phoneNumber = event.phoneNumber;
        User user = await userRepository.checkAndCreateUser(_user);
        sharedPreferences.setString('user', jsonEncode(user.toJson()));
        print('error');
        yield OTPVerifiedState(sharedPreferences: sharedPreferences);
      }
    }catch(e){
      print(e);
      yield VerificationFailedState();
    }
  }
}
