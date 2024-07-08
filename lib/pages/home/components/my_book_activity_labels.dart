import 'package:flutter/material.dart';

class MyBookActivityLabels extends StatefulWidget {
  final List<String> labels;
  final Function(int index)? itemTap;
  const MyBookActivityLabels({super.key, required this.labels, this.itemTap});

  @override
  State<MyBookActivityLabels> createState() => _MyBookActivityLabelsState();
}

class _MyBookActivityLabelsState extends State<MyBookActivityLabels> {
  int _value = 0;
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
          Wrap(
            children: List.generate(widget.labels.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(right: 10,bottom: 8),
                child: ChoiceChip(
                  label: Text(widget.labels[index]),
                  selected: _value == index,
                  onSelected: (value) {
                    if(_value == index) return;
                    setState(
                      () {
                        _value = index;
                      },
                    );
                    widget.itemTap?.call(index);
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
