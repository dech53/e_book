import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_book/utils/header_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyAuthorTile extends StatelessWidget {
  final List? authors;
  const MyAuthorTile({super.key, this.authors});

  @override
  Widget build(BuildContext context) {
    if (authors == null) {
      return SizedBox();
    } else {
      return Column(
        children: List.generate(authors!.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: CachedNetworkImage(
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                        imageUrl:
                            'https://img3.doubanio.com/view/personage/m/public/f0221380ea6f07ff04f87cce4c884842.jpg',
                        httpHeaders: HeaderUtil.randomHeader(),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          "马伯庸",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "作者",
                          style: TextStyle(
                              fontSize: 13,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "了解作者",
                      style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      size: 18,
                      color: Colors.black,
                    ),
                  ],
                )
              ],
            ),
          );
        }),
      );
    }
  }
}
