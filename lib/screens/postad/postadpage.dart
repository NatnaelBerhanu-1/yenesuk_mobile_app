import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:yenesuk/blocs/initbloc/initbloc.dart';
import 'package:yenesuk/blocs/initbloc/initstate.dart';
import 'package:yenesuk/blocs/postproductbloc/postproductbloc.dart';
import 'package:yenesuk/blocs/postproductbloc/postproductevent.dart';
import 'package:yenesuk/blocs/postproductbloc/postproductstate.dart';
import 'package:yenesuk/cloudinaryhelper.dart';
import 'package:yenesuk/models/category.dart';
import 'package:yenesuk/models/city.dart';
import 'package:yenesuk/models/requests/createAdRequest.dart';
import 'package:yenesuk/screens/postad/widgets/itemimage.dart';

class PostAdPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PostAdState();
}

class _PostAdState extends State<PostAdPage> {
  List<Asset> _images = List<Asset>();
  // List<String> images = ['assets/images/iphone.jpg'];
  CreateAdRequest _createAdRequest = new CreateAdRequest();
  Category _selectedCat;
  City _selectedCity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Post ad'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          padding: EdgeInsets.only(
            top: 0.0,
            // bottom: MediaQuery.of(context).viewInsets.bottom
          ),
          width: MediaQuery.of(context).size.width,
          child: BlocBuilder<PostProductBloc, PostProductState>(
            builder: (context, state) {
              if (state is PostFailedState) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('Can\'t post ad please try again'),
                  ));
                });
              }
              if (state is PostSuccessState) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  setState(() {
                    _images = List<Asset>();
                    _createAdRequest = new CreateAdRequest();
                  });
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('Ad successfully posted'),
                  ));
                });
              }
              return _buildPostForm(state);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPostForm(PostProductState state) {
    return Stack(children: [
      SingleChildScrollView(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 70.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _createAdRequest.name = value;
                      });
                    },
                    maxLength: 200,
                    maxLines: null,
                    decoration: InputDecoration(
                        errorText: state is PostFormInvalidState
                            ? state.postAdValidation.nameError
                            : null,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 10.0),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.0, color: Colors.grey))),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Category',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  InputDecorator(
                    decoration: InputDecoration(
                        errorText: state is PostFormInvalidState
                            ? state.postAdValidation.categoryError
                            : null,
                        contentPadding: EdgeInsets.all(5.0),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.0, color: Colors.grey))),
                    child: DropdownButtonHideUnderline(
                      child: BlocBuilder<InitBloc, InitState>(
                        builder: (context, state) {
                          if (state is FetchedState) {
                            return DropdownButton<Category>(
                              hint: Text("Select a category"),
                              value: _selectedCat,
                              isExpanded: false,
                              items: state.initData.categories
                                  .map((e) => DropdownMenuItem<Category>(
                                        value: e,
                                        child: Text(
                                          '${e.name}',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (cat) {
                                setState(() {
                                  _selectedCat = cat;
                                  _createAdRequest.categoryId = cat.id;
                                });
                              },
                            );
                          }
                          return DropdownButton(items: null, onChanged: null);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Condition',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  InputDecorator(
                    decoration: InputDecoration(
                        errorText: state is PostFormInvalidState
                            ? state.postAdValidation.conditionError
                            : null,
                        contentPadding: EdgeInsets.all(5.0),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.0, color: Colors.grey))),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text('Select condition'),
                        value: _createAdRequest.condition,
                        isExpanded: false,
                        items: <String>['New', 'Abroad Used', 'Ethiopian Used']
                            .map((e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: Text('$e'),
                                ))
                            .toList(),
                        onChanged: (String newVal) {
                          setState(() {
                            _createAdRequest.condition = newVal;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'City',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  InputDecorator(
                    decoration: InputDecoration(
                        errorText: state is PostFormInvalidState
                            ? state.postAdValidation.cityError
                            : null,
                        contentPadding: EdgeInsets.all(5.0),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.0, color: Colors.grey))),
                    child: DropdownButtonHideUnderline(
                      child: BlocBuilder<InitBloc, InitState>(
                        builder: (context, state) {
                          if (state is FetchedState) {
                            return DropdownButton<City>(
                              hint: Text('Select city'),
                              isExpanded: false,
                              value: _selectedCity,
                              items: state.initData.cities
                                  .map((e) => DropdownMenuItem<City>(
                                        value: e,
                                        child: Text('${e.name}'),
                                      ))
                                  .toList(),
                              onChanged: (city) {
                                setState(() {
                                  _selectedCity = city;
                                  _createAdRequest.cityId = city.id;
                                });
                              },
                            );
                          }
                          return DropdownButton(items: null, onChanged: null);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Price',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextField(
                    onChanged: (newVal) {
                      try {
                        setState(() {
                          _createAdRequest.price = double.parse(newVal);
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                    maxLines: 1,
                    maxLength: 15,
                    keyboardType:
                        TextInputType.numberWithOptions(signed: false),
                    decoration: InputDecoration(
                        errorText: state is PostFormInvalidState
                            ? state.postAdValidation.priceError
                            : null,
                        hintText: '0',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 10.0),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.0, color: Colors.grey))),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Description',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextField(
                    maxLength: 1000,
                    maxLines: null,
                    onChanged: (newVal) {
                      setState(() {
                        _createAdRequest.description = newVal;
                      });
                    },
                    decoration: InputDecoration(
                        errorText: state is PostFormInvalidState
                            ? state.postAdValidation.descriptionError
                            : null,
                        hintText: 'your description here',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 10.0),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.0, color: Colors.grey))),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Images',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                        'you can upload up to 5 images, please make sure your images are clear and visible'),
                  ),
                  state is PostFormInvalidState
                      ? state.postAdValidation.imagesError != null
                          ? Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                state.postAdValidation.imagesError,
                                style: TextStyle(color: Colors.red),
                              ),
                            )
                          : SizedBox()
                      : SizedBox(),
                  Container(
                    child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                        ),
                        itemCount: _images.length + 1,
                        itemBuilder: (context, i) {
                          if (i == _images.length && _images.length < 5) {
                            return ItemImage(
                              icon: Icons.add_circle,
                              onIconClicked: _pickImage,
                            );
                          }
                          if (i < _images.length) {
                            return ItemImage(
                              imageUrl: _images[i],
                              icon: Icons.cancel,
                              onIconClicked: removeImage,
                              index: i,
                            );
                          }
                          return null;
                        }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50.0,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: FlatButton(
            textColor: Colors.white,
            onPressed: () async {
              print('posting');
              // assume everything valid
              try {
                _createAdRequest.images = _images;
                BlocProvider.of<PostProductBloc>(context)
                    .add(PostAdEvent(adRequest: _createAdRequest));
              } catch (e) {
                print(e);
                // TODO: show error
              }
            },
            child: Text(
              'post ad',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ),
      ),
      if (state is PostingState)
        Opacity(
          opacity: .4,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpinKitCircle(
                    color: Colors.white,
                    size: 50.0,
                  ),
                  Text(
                    'Posting Ad...',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  )
                ],
              ),
            ),
          ),
        ),
    ]);
  }

  removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  Future<void> _pickImage() async {
    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5 - _images.length,
      );
    } catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      _images.addAll(resultList);
    });
  }
}
