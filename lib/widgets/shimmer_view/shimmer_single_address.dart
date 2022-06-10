import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerSingleAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Shimmer.fromColors(
          baseColor: Colors.black54,
          highlightColor: Colors.white,
          child: Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Container(
                height: 60,
                width: double.infinity,
                color: Colors.black38,
              )
          ),
        ),
      ],
    );
  }
}