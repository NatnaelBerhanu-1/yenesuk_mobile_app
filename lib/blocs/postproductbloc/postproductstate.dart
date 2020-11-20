import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:yenesuk/models/postadvalidation.dart';

abstract class PostProductState extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class PostIdleState extends PostProductState{

}

class PostSuccessState extends PostProductState{

}

class PostFormInvalidState extends PostProductState{
  final PostAdValidation postAdValidation;
  PostFormInvalidState({@required this.postAdValidation}):assert(postAdValidation!=null);
}

class PostFailedState extends PostProductState{

}

class PostingState extends PostProductState{

}