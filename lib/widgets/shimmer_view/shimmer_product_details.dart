import 'package:flutter/material.dart';
import 'package:harmis_opencart/utils/constant.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProductDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, left: 10.0, bottom: 10.0, right: 0.0),
      child: InkWell(
        onTap: (){

        },
        child: Wrap(
          children: <Widget>[
            Shimmer.fromColors(
              baseColor: Colors.black54,
              highlightColor: Colors.white,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 185.0,
                      margin: EdgeInsets.only(right: 10.0),
                      color: Colors.black26,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10.0,top: 12.0),
                        child: Container(
                          height: 9.5,
                          width: 150,
                          color: Colors.black26,
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10.0,top: 10.0, bottom: 20),
                        child: Container(
                          height: 9.5,
                          width: 100,
                          color: Colors.black26,
                        )
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
