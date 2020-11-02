import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.white12,
        direction: ShimmerDirection.ltr,
        child: Container(
          width: 130.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100.0,
                color: Colors.white38,
              ),
              Container(
                margin: EdgeInsets.only(top: 8.0),
                height: 15.0,
                color: Colors.white38,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                height: 15.0,
                width: 100,
                color: Colors.white38,
              ),
              Container(
                height: 15.0,
                width: 65.0,
                color: Colors.white38,
              ),
            ],
          ),
        ),
      ),
    );
  }
}