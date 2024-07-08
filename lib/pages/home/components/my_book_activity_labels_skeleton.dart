import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyBookActivityLabelsSkeleton extends StatelessWidget {
  const MyBookActivityLabelsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "活动类型",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 5,
          ),
          Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.inverseSurface,
            highlightColor: Theme.of(context).colorScheme.onInverseSurface,
            child: Wrap(
              children: List.generate(6, (index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10,bottom: 8),
                  child: Container(
                    height: 40,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.inverseSurface,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
