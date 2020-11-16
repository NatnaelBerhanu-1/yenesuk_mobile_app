import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:yenesuk/models/Item.dart';
import 'package:yenesuk/models/responses/getitemsresponse.dart';

abstract class ProductState extends Equatable{
  @override
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
  List<Object> get props => [data.page];
}
class ProductErrorState extends ProductState{}
class ProductEmptyState extends ProductState{}