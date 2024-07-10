import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class MyBookContentTitle extends StatelessWidget {
  final String? content;
  final String? labelTitle;
  final List<String>? labels;
  const MyBookContentTitle(
      {super.key, this.content, this.labelTitle, this.labels});

  @override
  Widget build(BuildContext context) {
    if (context == null) {
      return SizedBox();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //标题
          Text(
            "内容简介",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          ReadMoreText(
            content ?? "",
            trimLines: 8,
            trimLength: 200,
            trimCollapsedText: "更多",
            trimExpandedText: "收起",
            colorClickableText: Theme.of(context).colorScheme.primary,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            labelTitle ?? "",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Wrap(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: ActionChip(
                  label: Text(
                    "京东商城:￥28.0",
                    style: TextStyle(fontSize: 12),
                  ),
                  onPressed: () {},
                ),
              ),
               Padding(
                padding: EdgeInsets.only(right: 10),
                child: ActionChip(
                  label: Text(
                    "豆瓣商城:￥28.0",
                    style: TextStyle(fontSize: 12),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      );
    }
  }
}
