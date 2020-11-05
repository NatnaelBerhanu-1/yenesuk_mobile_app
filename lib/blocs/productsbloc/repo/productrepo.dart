import 'package:yenesuk/blocs/productsbloc/service/productservice.dart';
import 'package:yenesuk/models/Item.dart';

class ProductRepository {
  ProductService _productService = ProductService();

  Future<List<Item>> getItems([int page=0]) async {
    return await _productService.getItems(page);
  }

  Future<List<Item>> searchItems(String searchKey) async {
    return await _productService.searchItems(searchKey);
  }
}