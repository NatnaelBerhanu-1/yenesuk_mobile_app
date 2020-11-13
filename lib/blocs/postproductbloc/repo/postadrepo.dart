import 'dart:ffi';

import 'package:yenesuk/blocs/postproductbloc/service/postadservice.dart';
import 'package:yenesuk/models/requests/createAdRequest.dart';

class PostAdRepo{
  PostAdService _postAdService = new PostAdService();

  Future<Void> postAd({CreateAdRequest adRequest}) async {
    await _postAdService.postAd(adRequest: adRequest);
  }

}