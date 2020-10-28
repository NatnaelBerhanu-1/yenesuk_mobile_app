import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerItemWidget extends StatelessWidget{
  final String title;
  final Widget goto;

  DrawerItemWidget({@required this.title, @required this.goto});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: ListTile(
        title: Text('$title'),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => goto));
        },
      ),
    );
  }
}