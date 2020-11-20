import 'dart:ffi';

import 'package:yenesuk/blocs/productsbloc/service/productservice.dart';
import 'package:yenesuk/models/Item.dart';
import 'package:yenesuk/models/requests/createAdRequest.dart';
import 'package:yenesuk/models/responses/getitemsresponse.dart';

class ProductRepository {
  ProductService _productService = ProductService();

  Future<GetItemsResponse> getItems([int page=0]) async {
    return await _productService.getItems(page);
  }

  Future<GetItemsResponse> searchItems({String searchKey, int page}) async {
    return await _productService.searchItems(searchKey, page);
  }

  getSingleItem({String id}) async {
    return await _productService.getSingleItem(id);
  }

  Future<GetItemsResponse> getItemsByCategory(String categoryId, int page) async {
    return await _productService.getItemsByCategory(categoryId, page);
  }

  Future<Void> postAd({CreateAdRequest adRequest}) async {
    await _productService.postAd(adRequest: adRequest);
  }
}