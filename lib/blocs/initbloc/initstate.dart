import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:yenesuk/models/initdata.dart';

class InitState extends Equatable{
  @override
  List<Object> get props => [];
}

class FetchingState extends InitState{}
class FetchedState extends InitState{
  final InitData initData;
  FetchedState({@required this.initData}):assert(initData!=null);
}
class ErrorState extends InitState{}