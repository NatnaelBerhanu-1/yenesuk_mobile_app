import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yenesuk/blocs/loginbloc/loginbloc.dart';
import 'package:yenesuk/blocs/loginbloc/loginevent.dart';
import 'otpverif.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          padding: EdgeInsets.only(top: 40.0),
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.clear,
                        color: Colors.black,
                        size: 24.0,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(right: 34.0),
                          child: Text(
                            'Continue with Phone',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Image.asset(
                    'assets/images/phone_input.png',
                    height: 150,
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'You will receive a code to\nverify your number',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 100),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(width: 1.0, color: Colors.black12)
                            )),
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('+251', style: TextStyle(fontSize: 18.0),),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: VerticalDivider(),
                              ),
                              SizedBox(
                                width: 120,
                                child: TextField(
                                  onChanged: (value){
                                    setState(() {
                                      phoneNumber = value;
                                    });
                                  },
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'phone number',
                                    hintStyle: TextStyle(color: Colors.black12),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: FlatButton(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          onPressed: () {
                            // TODO: verify phone number;
                            if(phoneNumber.length != 9 || int.parse(phoneNumber).isNaN) return;
                            phoneNumber = '+251$phoneNumber';
                            BlocProvider.of<LoginBloc>(context).add(SendOTPEvent(phoneNumber: phoneNumber));
                            Navigator.of(context).pop();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OTPVerification(phoneNum: phoneNumber,)));
                          },
                          color: Theme.of(context).primaryColor,
                          child: Text(
                            'Continue',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'by clicking continue you agree to our',
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        'terms of service',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
