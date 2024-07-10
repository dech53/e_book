import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyBookDetailTile extends StatelessWidget {
  final List<String> data;
  final List<String> labels;
  const MyBookDetailTile({super.key, required this.data, required this.labels});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(labels.length, (index) {
        return SizedBox(
          width: 100,
          child: Column(
            children: [
              Text(
                data[index],
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                labels[index],
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.inversePrimary),
              )
            ],
          ),
        );
      }),
    );
  }
}
