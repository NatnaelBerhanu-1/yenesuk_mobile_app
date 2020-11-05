import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yenesuk/blocs/productsbloc/productevent.dart';
import 'package:yenesuk/blocs/productsbloc/productstate.dart';
import 'package:yenesuk/blocs/productsbloc/repo/productrepo.dart';
import 'package:yenesuk/models/Item.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState>{

  final ProductRepository productRepository;
  ProductBloc({this.productRepository}):assert(productRepository!=null), super(ProductFetchingState());

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async*{
    yield ProductFetchingState();
    List<Item> items;
    try{
      if(event is GetProductsEvent){
        items = await productRepository.getItems(event.page);
      }else if(event is SearchTextChangedEvent){
        items = await productRepository.searchItems(event.searchText);
      }
      if(items.length == 0){
        yield ProductEmptyState();
      }else{
        yield ProductFetchedState(items: items);
      }
    }catch(e){
      print(e);
      yield ProductErrorState();
    }
  }

}