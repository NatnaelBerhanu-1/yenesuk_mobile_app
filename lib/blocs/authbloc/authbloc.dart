import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc extends Bloc<AuthEvent, AuthState>{
  AuthenticationBloc():super(Unauthenticated());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    try{
      if(event is AppStarted){
       bool auth = await FirebaseAuth.instance.currentUser() !=null;
       print('fb: ${await FirebaseAuth.instance.currentUser()}');
       if(auth){
         print('authenticated');
         yield Authenticated();
       }else{
         print('unauthenticated');
         yield Unauthenticated();
       }
      }else if(event is Logout){
        await FirebaseAuth.instance.signOut();
        yield Unauthenticated();
      }
    }catch(error){
      print(error);
      yield Unauthenticated();
    }
  }

}

abstract class AuthState extends Equatable{
  @override
  List<Object> get props => [];
}

class Authenticated extends AuthState{}
class Unauthenticated extends AuthState{}

abstract class AuthEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class AppStarted extends AuthEvent{}
class Logout extends AuthEvent{}