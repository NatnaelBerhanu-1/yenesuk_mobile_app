import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yenesuk/blocs/initbloc/initevent.dart';
import 'package:yenesuk/blocs/initbloc/initstate.dart';
import 'package:yenesuk/blocs/initbloc/repo/initrepo.dart';
import 'package:yenesuk/models/initdata.dart';

class InitBloc extends Bloc<InitEvent, InitState>{
    final InitRepository initRepo;
    final SharedPreferences sharedPreferences;
    InitBloc({@required this.initRepo, @required this.sharedPreferences}):super(FetchingState());

  @override
  Stream<InitState> mapEventToState(InitEvent event) async* {
    yield FetchingState();
    InitData initData;
    try{
      if(event is GetInit){
        initData = await initRepo.getInitData();
      }
      yield FetchedState(initData: initData, sharedPreferences: sharedPreferences);
    }catch(error){
      print(error);
      yield ErrorState();
    }
  }
}