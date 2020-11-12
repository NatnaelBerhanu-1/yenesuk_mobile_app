import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yenesuk/blocs/productsbloc/productevent.dart';
import 'package:yenesuk/blocs/productsbloc/productstate.dart';
import 'package:yenesuk/blocs/productsbloc/repo/productrepo.dart';
import 'package:yenesuk/models/Item.dart';
import 'package:yenesuk/models/responses/getitemsresponse.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  ProductBloc({this.productRepository})
      : assert(productRepository != null),
        super(ProductFetchingState());

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    GetItemsResponse data;
    try {
      yield ProductFetchingState();
      if (event is GetProductsEvent) {
        data = await productRepository.getItems(event.page);
      } else if (event is SearchTextChangedEvent) {
        data = await productRepository.searchItems(searchKey: event.searchText);
      } else if (event is GetProductsByCategoryEvent) {
        data = await productRepository.getItemsByCategory(
            event.categoryId, event.page);
      }
      if (data.items.length == 0) {
        yield ProductEmptyState();
      } else {
        yield ProductFetchedState(data: data);
      }
    } catch (e) {
      print(e);
      yield ProductErrorState();
    }
  }
}
