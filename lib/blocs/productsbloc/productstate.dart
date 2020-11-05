import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:yenesuk/models/Item.dart';

abstract class ProductState extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ProductFetchingState extends ProductState{
}
class ProductFetchedState extends ProductState{
  final List<Item> items;
  ProductFetchedState({@required this.items}):assert(items!=null);

  @override
  // TODO: implement props
  List<Object> get props => [items];
}
class ProductErrorState extends ProductState{}
class ProductEmptyState extends ProductState{}