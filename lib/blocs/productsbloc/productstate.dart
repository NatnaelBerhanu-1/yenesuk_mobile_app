import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:yenesuk/models/Item.dart';
import 'package:yenesuk/models/responses/getitemsresponse.dart';

abstract class ProductState extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ProductIdleState extends ProductState{

}

class ProductFetchingState extends ProductState{
}
class ProductFetchedState extends ProductState{
  final GetItemsResponse data;
  ProductFetchedState({@required this.data}):assert(data!=null);

  @override
  // TODO: implement props
  List<Object> get props => [data];
}
class ProductErrorState extends ProductState{}
class ProductEmptyState extends ProductState{}