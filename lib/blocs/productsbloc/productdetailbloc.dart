import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:yenesuk/blocs/productsbloc/productevent.dart';
import 'package:yenesuk/blocs/productsbloc/productstate.dart';
import 'package:yenesuk/blocs/productsbloc/repo/productrepo.dart';
import 'package:yenesuk/models/Item.dart';
import 'package:yenesuk/models/responses/getitemsresponse.dart';

class ProductDetailsBloc extends Bloc<ProductEvent, ProductState>{
  final ProductRepository productRepository;
  ProductDetailsBloc({@required this.productRepository}):super(ProductFetchingState());


  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async*{
    yield ProductFetchingState();
    Item item;
    try{
      if(event is GetSingleProductEvent){
        item = await productRepository.getSingleItem(id: event.id);
      }
      if(item==null){
        yield ProductEmptyState();
      }else{
        yield ProductFetchedState(data: GetItemsResponse(items: [item]));
      }
    }catch(_){
      yield ProductErrorState();
    }
  }

}