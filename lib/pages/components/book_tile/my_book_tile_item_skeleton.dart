import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../model/book.dart';

class MyBookTileItemSkeleton extends StatelessWidget {
  final double? height;
  final double? width;
  final bool? showPrice;
  const MyBookTileItemSkeleton(
      {super.key, this.height, this.width, this.showPrice = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 15),
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).colorScheme.inverseSurface,
        highlightColor: Theme.of(context).colorScheme.onInverseSurface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).colorScheme.inverseSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            //标题
            Container(
              padding: EdgeInsets.only(top: 10),
              width: width,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
            ),
            const SizedBox(height: 5,),
            Container(
              padding: EdgeInsets.only(top: 5),
              width: width ==null?null:width!-20,
              height: 18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
