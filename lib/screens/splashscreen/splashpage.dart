import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yenesuk/blocs/initbloc/initbloc.dart';
import 'package:yenesuk/blocs/initbloc/initevent.dart';
import 'package:yenesuk/blocs/initbloc/initstate.dart';
import 'package:yenesuk/models/user.dart';
import 'package:yenesuk/screens/homepage/homepage.dart';
import 'package:yenesuk/screens/loginpage/createaccountpage.dart';
import 'package:yenesuk/screens/productspage/widgets/tryagain.dart';

class SplashPage extends StatefulWidget{

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Abay',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 36.0,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'ecommerce',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black26,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50.0,
              child: BlocConsumer<InitBloc, InitState>(
                listener: (context, state){
                  print('splash: $state');
                  if (state is FetchedState){
                    WidgetsBinding.instance
                        .addPostFrameCallback((timeStamp) {
                        var usr = state.sharedPreferences.getString('user');
                      if(usr != null){
                        User user = User.fromJson(jsonDecode(usr));
                        if(user.firstName == null || user.lastName == null || user.profilePicture == null){
                          print('here');
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateAccountPage()));
                        }else{
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                        }
                      }else{
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                      }

                    });
                  }
                },
                builder: (context, state){
                  if (state is ErrorState){
                    return RetryWidget(
                      message: 'Failed',
                      onTap: (){
                        BlocProvider.of<InitBloc>(context).add(GetInit());
                      },
                    );
                  }
                  return SpinKitWave(
                    color: Theme.of(context).primaryColor,
                    duration: Duration(seconds: 1),
                    size: 20,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}