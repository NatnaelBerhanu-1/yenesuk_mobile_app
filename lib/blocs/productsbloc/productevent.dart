import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:yenesuk/models/requests/createAdRequest.dart';

abstract class ProductEvent extends Equatable{}

class GetProductsEvent extends ProductEvent{
  final int page;
  GetProductsEvent({@required this.page}):assert(page!=null);

  @override
  // TODO: implement props
  List<Object> get props => [page];
}

class GetProductsByCategoryEvent extends ProductEvent{
  final String categoryId;
  final int page;
  GetProductsByCategoryEvent({@required this.categoryId, @required this.page});

  @override
  List<Object> get props => [categoryId];
}

class GetSingleProductEvent extends ProductEvent{
  final String id;
  GetSingleProductEvent({@required this.id}):assert(id!=null);

  @override
  List<Object> get props => [id];
}

class SearchTextChangedEvent extends ProductEvent{
  final String searchText;
  final int page;
  SearchTextChangedEvent({@required this.searchText, @required this.page}) : assert(searchText!=null&&page!=null);

  @override
  List<Object> get props => [searchText];
}