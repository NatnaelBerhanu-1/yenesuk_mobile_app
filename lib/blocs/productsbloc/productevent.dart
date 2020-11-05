import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ProductEvent extends Equatable{}

class GetProductsEvent extends ProductEvent{
  final int page;
  GetProductsEvent({@required this.page}):assert(page!=null);

  @override
  // TODO: implement props
  List<Object> get props => [page];
}

class SearchTextChangedEvent extends ProductEvent{
  final String searchText;
  SearchTextChangedEvent({@required this.searchText}) : assert(searchText!=null);

  @override
  // TODO: implement props
  List<Object> get props => [searchText];
}