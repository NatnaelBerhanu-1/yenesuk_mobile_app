import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:yenesuk/blocs/loginbloc/loginbloc.dart';
import 'package:yenesuk/blocs/loginbloc/loginevent.dart';
import 'package:yenesuk/blocs/loginbloc/loginstate.dart';
import 'package:yenesuk/models/user.dart';
import 'package:yenesuk/screens/homepage/homepage.dart';
import 'package:yenesuk/screens/loginpage/createaccountpage.dart';
import 'package:yenesuk/screens/loginpage/loginpage.dart';
import 'package:yenesuk/screens/splashscreen/splashpage.dart';

class OTPVerification extends StatefulWidget {
  final phoneNum;
  OTPVerification({@required this.phoneNum}) : assert(phoneNum != null);

  @override
  _OTPVerificationState createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  String _OTP;
  final _drawerKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          key: _drawerKey,
      backgroundColor: Colors.white,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state){
          print(state);
          if(state is VerificationFailedState){
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Scaffold.of(context).showSnackBar(SnackBar(content: Text('Authentication Failed, try again')));
            });
          }
          if(state is OTPVerifiedState){
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.pop(context);
              User user = User.fromJson(jsonDecode(state.sharedPreferences.getString('user')));
              if(user.firstName == null || user.lastName == null || user.profilePicture == null){
                print('here');
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateAccountPage()));
              }else{
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SplashPage()));
              }
            });
          }
        },
        builder: (context, state){
          print(state);
          if(state is IdleState){
            return Center(
              child: SpinKitCubeGrid(
                color: Theme.of(context).primaryColor,
                size: 30,
              ),
            );
          }else{
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Continue with Phone',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'code is sent to ${widget.phoneNum}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  OTPTextField(
                    length: 6,
                    width: 250,
                    onCompleted: (pin) {
                      setState(() {
                        _OTP = pin;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Didn\'t receive code?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                        },
                        child: Text(
                          'Request again',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(vertical: 15.0),
                    child: state is VerifyingOTPState ? SpinKitWave(
                      color: Theme.of(context).primaryColor,
                      size: 20.0,
                    )
                        : FlatButton(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      onPressed: () {
                        // TODO: verify phone number;
                        BlocProvider.of<LoginBloc>(context).add(VerifyOTPEvent(otp: _OTP, phoneNumber: widget.phoneNum));
                      },
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        'Verify and Continue',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }
      ),
    ));
  }
}
