import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrimaryTitle extends StatelessWidget {
  final String title;

  PrimaryTitle({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Text(
        '$title',
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
