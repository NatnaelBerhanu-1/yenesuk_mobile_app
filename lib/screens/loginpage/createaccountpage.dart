import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yenesuk/blocs/authbloc/authbloc.dart';
import 'package:yenesuk/blocs/loginbloc/createaccountbloc.dart';
import 'package:yenesuk/blocs/loginbloc/createaccountevent.dart';
import 'package:yenesuk/blocs/loginbloc/createaccountstate.dart';
import 'package:yenesuk/models/user.dart';
import 'package:yenesuk/screens/homepage/homepage.dart';
import 'package:yenesuk/screens/splashscreen/splashpage.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  String firstName, lastName;
  Asset _image;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Create Account'),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: BlocConsumer<CreateAccountBloc, CreateAccountState>(
        listener: (context, state) {
          if (state is FailedState) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              showSnackBar(context, 'Something went wrong, try again');
            });
          }
          if (state is SuccessState){
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              state.sharedPreferences.setString('user', jsonEncode(state.user.toJson()));
              BlocProvider.of<AuthenticationBloc>(context).add(AppStarted());
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
            });
          }
        },
        builder: (context, state) => Container(
          padding: EdgeInsets.only(top: 20, left: 15.0, right: 15.0),
          color: Theme.of(context).primaryColor,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  _pickImage();
                },
                child: _image == null
                    ? CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage('assets/images/profilenoimage.png'))
                    : ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        child: AssetThumb(
                          asset: _image,
                          height: 100,
                          width: 100,
                        ),
                      ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                'Profile picture',
                style: TextStyle(color: Colors.white70),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  height: 50.0,
                  child: TextField(
                    cursorColor: Colors.white,
                    onChanged: (newVal) {
                      setState(() {
                        firstName = newVal;
                      });
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'First Name',
                      hintStyle: TextStyle(
                        color: Colors.white38,
                      ),
                      filled: true,
                      fillColor: Colors.black12,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(style: BorderStyle.none),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1.0, color: Theme.of(context).accentColor),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  height: 50.0,
                  child: TextField(
                    cursorColor: Colors.white,
                    onChanged: (newVal) {
                      setState(() {
                        lastName = newVal;
                      });
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Last Name',
                      hintStyle: TextStyle(
                        color: Colors.white38,
                      ),
                      filled: true,
                      fillColor: Colors.black12,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(style: BorderStyle.none),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 0),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1.0, color: Theme.of(context).accentColor),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                    ),
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 10.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: state is BusyState
                      ? Center(
                          child: SpinKitWave(
                          color: Theme.of(context).accentColor,
                          size: 20,
                        ))
                      : FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0))),
                          height: 50.0,
                          onPressed: () async {
                            // Todo do validation
                            print('fname: $firstName');
                            if (_image == null) {
                              showSnackBar(context, 'Choose profile picture');
                              return;
                            } else if (firstName == null && lastName == null) {
                              showSnackBar(
                                  context, 'First and Last name are required');
                              return;
                            } else if (firstName == null) {
                              showSnackBar(context, 'First name is required');
                              return;
                            } else if (lastName == null) {
                              showSnackBar(context, 'Last name is required');
                              return;
                            }
                            var sharedPrefs = await SharedPreferences.getInstance();
                            User user = User.fromJson(jsonDecode(sharedPrefs.getString('user')));
                            user.firstName = firstName;
                            user.lastName = lastName;
                            BlocProvider.of<CreateAccountBloc>(context)
                                .add(CreateEvent(user: user, image: _image));
                          },
                          child: Text('Create Account'),
                          color: Theme.of(context).accentColor,
                        ))
            ],
          ),
        ),
      ),
    ));
  }

  showSnackBar(context, text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text('$text')));
  }

  Future<void> _pickImage() async {
    List<Asset> resultList = new List<Asset>();
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
          enableCamera: true,
          maxImages: 1,
      );
    } catch (e) {
      print(e);
      error = e.toString();
    }

    if (!mounted) return;
    if (resultList.length > 0)
      setState(() {
        _image = resultList[0];
      });
  }
}
