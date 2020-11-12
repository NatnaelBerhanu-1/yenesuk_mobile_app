import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yenesuk/blocs/initbloc/initevent.dart';
import 'package:yenesuk/blocs/initbloc/initstate.dart';
import 'package:yenesuk/blocs/initbloc/repo/initrepo.dart';
import 'package:yenesuk/models/initdata.dart';

class InitBloc extends Bloc<InitEvent, InitState>{
    InitRepository initRepo;
    InitBloc({this.initRepo}):super(FetchingState());

  @override
  Stream<InitState> mapEventToState(InitEvent event) async* {
    yield FetchingState();
    InitData initData;
    try{
      if(event is GetInit){
        initData = await initRepo.getInitData();
      }
      yield FetchedState(initData: initData);
    }catch(error){
      print(error);
      yield ErrorState();
    }
  }
}