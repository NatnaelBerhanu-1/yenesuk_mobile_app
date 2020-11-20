import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:yenesuk/models/user.dart';

abstract class CreateAccountEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class CreateEvent extends CreateAccountEvent{
  final User user;
  final Asset image;
  CreateEvent({@required this.user, @required this.image}):assert(user!=null&&image!=null);
}