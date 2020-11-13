import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:yenesuk/models/requests/createAdRequest.dart';

class PostProductEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class PostAdEvent extends PostProductEvent{
  final CreateAdRequest adRequest;
  PostAdEvent({@required this.adRequest}):assert(adRequest!=null);

  @override
  List<Object> get props => [adRequest];
}