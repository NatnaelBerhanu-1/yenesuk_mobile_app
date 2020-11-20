import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yenesuk/blocs/loginbloc/createaccountevent.dart';
import 'package:yenesuk/blocs/loginbloc/createaccountstate.dart';
import 'package:yenesuk/blocs/loginbloc/userrepo.dart';
import 'package:yenesuk/models/user.dart';

class CreateAccountBloc extends Bloc<CreateAccountEvent, CreateAccountState>{
  final UserRepository userRepository;
  final SharedPreferences sharedPreferences;
  CreateAccountBloc({@required this.userRepository, @required this.sharedPreferences}):assert(userRepository!=null&&sharedPreferences!=null),super(IdleState());

  @override
  Stream<CreateAccountState> mapEventToState(CreateAccountEvent event) async* {
    yield BusyState();
    try{
      if(event is CreateEvent){
        User user = await userRepository.updateUser(event.user, event.image);
        print('success state');
        yield SuccessState(user: user, sharedPreferences: sharedPreferences);
      }
    }catch(error){
      print(error);
      yield FailedState();
    }
  }
}