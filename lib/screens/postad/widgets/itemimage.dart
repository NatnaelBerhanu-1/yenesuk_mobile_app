import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class ItemImage extends StatelessWidget {
  final imageUrl;
  final IconData icon;
  final Function onIconClicked;
  final int index;

  ItemImage(
      {this.imageUrl,
      @required this.icon,
      @required this.onIconClicked,
      this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          )),
      child: Stack(
        alignment: Alignment.center,
        children: [
          imageUrl != null
              ? ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: AssetThumb(
                    asset: imageUrl,
                    height: 100,
                    width: 100,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    onIconClicked();
                  },
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    color: Colors.grey,
                  ),
                ),
          IconButton(
            onPressed: () {
              if (index != null) {
                onIconClicked(index);
              }
              onIconClicked();
            },
            padding: EdgeInsets.zero,
            icon: Icon(
              icon,
              color: Colors.white,
              size: 50,
            ),
          )
        ],
      ),
    );
  }
}
