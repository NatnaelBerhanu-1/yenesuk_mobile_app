import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yenesuk/blocs/postproductbloc/postproductevent.dart';
import 'package:yenesuk/blocs/postproductbloc/postproductstate.dart';
import 'package:yenesuk/blocs/productsbloc/repo/productrepo.dart';
import 'package:yenesuk/models/postadvalidation.dart';
import 'package:yenesuk/models/requests/createAdRequest.dart';
import 'package:yenesuk/models/user.dart';

class PostProductBloc extends Bloc<PostProductEvent, PostProductState> {
  final ProductRepository productRepository;
  final SharedPreferences sharedPreferences;
  PostProductBloc(
      {@required this.productRepository, @required this.sharedPreferences})
      : assert(productRepository != null && sharedPreferences != null),
        super(PostIdleState());

  @override
  Stream<PostProductState> mapEventToState(PostProductEvent event) async* {
    yield PostingState();
    PostAdValidation postAdValidation = new PostAdValidation();
    try {
      if (event is PostAdEvent) {
        print('posting ad');
        if (validateInput(postAdValidation, event.adRequest)) {
          print('form valid');
          User user = User.fromJson(jsonDecode(sharedPreferences.getString('user')));
          event.adRequest.userId = user.id;
          await productRepository.postAd(adRequest: event.adRequest);
          yield PostSuccessState();
          yield PostIdleState();
        } else {
          yield PostFormInvalidState(postAdValidation: postAdValidation);
        }
      }
    } catch (e) {
      print('Posting failed');
      print(e);
      yield PostFailedState();
      yield PostIdleState();
    }
  }

  bool validateInput(
      PostAdValidation postAdValidation, CreateAdRequest adRequest) {
    bool validated = true;
    // Validate each input
    if (adRequest.name == null) {
      postAdValidation.nameError = "Name is required";
      validated = false;
    } else if (adRequest.name.isEmpty) {
      postAdValidation.nameError = "Name is required";
      validated = false;
    }
    if (adRequest.categoryId == null) {
      postAdValidation.categoryError = "Category is required";
      validated = false;
    } else if (adRequest.categoryId.isEmpty) {
      postAdValidation.categoryError = "Category is required";
      validated = false;
    }
    if (adRequest.condition == null) {
      postAdValidation.conditionError = "Condition is required";
      validated = false;
    } else if (adRequest.condition.isEmpty) {
      postAdValidation.conditionError = "Condition is required";
      validated = false;
    }
    if (adRequest.cityId == null) {
      postAdValidation.cityError = "City is required";
      validated = false;
    } else if (adRequest.cityId.isEmpty) {
      postAdValidation.cityError = "City is required";
      validated = false;
    }
    if (adRequest.price == null) {
      postAdValidation.priceError = "Price Invalid";
      validated = false;
    } else if (adRequest.price.isNaN || adRequest.price.isNegative) {
      postAdValidation.priceError = "Price Invalid";
      validated = false;
    }
    if (adRequest.description == null) {
      postAdValidation.descriptionError = "Description is required";
      validated = false;
    } else if (adRequest.description.isEmpty) {
      postAdValidation.descriptionError = "Description is required";
      validated = false;
    }
    if (adRequest.images == null) {
      postAdValidation.imagesError = "Upload at least one image";
      validated = false;
    } else if (adRequest.images.length == 0) {
      postAdValidation.imagesError = "Upload at least one image";
      validated = false;
    }

    return validated;
  }
}
