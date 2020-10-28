import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostadPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PostadState();

}

class _PostadState extends State<PostadPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Post ad'
        ),
      ),
    );
  }
}