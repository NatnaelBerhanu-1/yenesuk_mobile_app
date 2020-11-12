import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yenesuk/blocs/productsbloc/productevent.dart';
import 'package:yenesuk/blocs/productsbloc/productstate.dart';
import 'package:yenesuk/blocs/productsbloc/repo/productrepo.dart';
import 'package:yenesuk/models/Item.dart';
import 'package:yenesuk/models/responses/getitemsresponse.dart';

class SearchBloc extends Bloc<ProductEvent, ProductState>{
  ProductRepository productRepository;
  SearchBloc({@required this.productRepository}):assert(productRepository!=null), super(ProductIdleState());


  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async*{
    yield ProductFetchingState();
    try{
      GetItemsResponse data;
      if(event is SearchTextChangedEvent){
        data = await productRepository.searchItems(searchKey: event.searchText, page: event.page);
      }
      print('length: ${data.items.length}');
      if(data.items.length == 0){
        yield ProductEmptyState();
      }else{
        yield ProductFetchedState(data: data);
      }
    }catch(e){
      print(e);
      yield ProductErrorState();
    }
  }
}