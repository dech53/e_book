import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_book/utils/header_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../model/book.dart';

class MyBookTileItem extends StatelessWidget {
  final Book book;
  final double? height;
  final double? width;
  final bool? showPrice;
  final bool? showRate;
  const MyBookTileItem(
      {super.key,
      required this.book,
      this.height,
      this.width,
      this.showPrice = false,
      this.showRate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 15),
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
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      book.cover ?? "",
                      headers: HeaderUtil.randomHeader(),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              //价格
              _getPriceUI(context),
            ],
          ),
          //标题
          Container(
            padding: EdgeInsets.only(top: 10),
            width: width,
            child: Text(
              maxLines: 1,
              book.title ?? "",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            width: width,
            child: Text(
              maxLines: 1,
              book.subTitle ?? book.authorName ?? "",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          //评分组件
          _getRateUI(),
        ],
      ),
    );
  }

  Widget _getRateUI() {
    if (showRate != true) {
      return const SizedBox();
    }
    return Container(
      margin: EdgeInsets.only(top: 6),
      width: width,
      child: Row(
        children: [
          RatingBar.builder(
            itemCount: 5,
            ignoreGestures: true,
            initialRating: (book.rate??0.0)/2,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemPadding: EdgeInsets.only(right: 2),
            itemSize: 15,
              itemBuilder: (context, _) {
                return Icon(
                  Icons.star,
                  color: Theme.of(context).colorScheme.tertiary,
                );
              },
              onRatingUpdate: (rating) {

              })
        ],
      ),
    );
  }

  Widget _getPriceUI(BuildContext context) {
    if (showPrice == false) {
      return const SizedBox();
    }
    return Positioned(
      bottom: height == null ? 20 : height! / 6,
      child: Container(
        width: 65,
        height: 25,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Center(
          child: Text(
            "￥12.0",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
