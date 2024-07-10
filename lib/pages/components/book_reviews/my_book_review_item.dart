import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_book/utils/header_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyBookReviewItem extends StatelessWidget {
  final String review;
  const MyBookReviewItem({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipOval(
                child: CachedNetworkImage(
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                  imageUrl:
                      'https://img3.doubanio.com/icon/u52562951-7.jpg',
                  httpHeaders: HeaderUtil.randomHeader(),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Jenny_shaw",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  //评分
                  RatingBar.builder(
                      itemCount: 5,
                      ignoreGestures: true,
                      initialRating: (9.8 ?? 0.0) / 2,
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
                      onRatingUpdate: (rating) {}),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            review,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
