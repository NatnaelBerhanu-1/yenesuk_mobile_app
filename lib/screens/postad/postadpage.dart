import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:yenesuk/screens/postad/widgets/itemimage.dart';

class PostadPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PostadState();
}

class _PostadState extends State<PostadPage> {
  List<Asset> _images = List<Asset>();
  // List<String> images = ['assets/images/iphone.jpg'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Post ad'),
      ),
      body: Container(
        padding: EdgeInsets.only(
            top: 0.0,
            // bottom: MediaQuery.of(context).viewInsets.bottom
        ),
        width: MediaQuery.of(context).size.width,
        child: Stack(children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 70.0
            ),
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
                        maxLength: 200,
                        maxLines: null,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 10.0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.0, color: Colors.grey))),
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
                            contentPadding: EdgeInsets.all(5.0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.0, color: Colors.grey))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: false,
                            items: <String>['One', 'Two', 'Three', 'Four']
                                .map((e) => DropdownMenuItem<String>(
                                      child: Text('$e'),
                                    ))
                                .toList(),
                            onChanged: (String newVal) {
                              print(newVal);
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
                            contentPadding: EdgeInsets.all(5.0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.0, color: Colors.grey))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: false,
                            items:
                                <String>['New', 'Abroad Used', 'Ethiopian Used']
                                    .map((e) => DropdownMenuItem<String>(
                                          child: Text('$e'),
                                        ))
                                    .toList(),
                            onChanged: (String newVal) {
                              print(newVal);
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
                            contentPadding: EdgeInsets.all(5.0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.0, color: Colors.grey))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: false,
                            items:
                                <String>['AddisAbaba', 'Two', 'Three', 'Four']
                                    .map((e) => DropdownMenuItem<String>(
                                          child: Text('$e'),
                                        ))
                                    .toList(),
                            onChanged: (String newVal) {
                              print(newVal);
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
                        maxLines: 1,
                        maxLength: 15,
                        keyboardType:
                            TextInputType.numberWithOptions(signed: false),
                        decoration: InputDecoration(
                            hintText: '0',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 10.0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.0, color: Colors.grey))),
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
                        decoration: InputDecoration(
                            hintText: 'your description here',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 10.0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.0, color: Colors.grey))),
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
                      Container(
                        child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                            ),
                            itemCount: _images.length + 1,
                            itemBuilder: (context, i) {
                              print('${_images.length} ${i + 1}');
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
                onPressed: () {},
                child: Text(
                  'post ad',
                  style: TextStyle(
                    fontSize: 18.0
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
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
