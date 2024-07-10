import 'package:e_book/pages/components/book_reviews/my_book_review_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyBookReview extends StatelessWidget {
  final List? reviews;
  const MyBookReview({super.key, this.reviews});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '书评',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          children: List.generate(
            reviews?.length ?? 4,
            (index) {
              if (reviews == null) {
                return const SizedBox();
              } else {
                return MyBookReviewItem(review: reviews![index]);
              }
            },
          ),
        )
      ],
    );
  }
}
