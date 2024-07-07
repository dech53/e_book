import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyBookTile extends StatelessWidget {
  final List<Map<String, dynamic>> books;
  final double? height;
  final double? width;
  const MyBookTile(
      {super.key,
      required this.books,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "特别推荐",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        //书籍信息
        const SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              books.length,
              (index) {
                return Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Column(
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
                                  books[index]['cover'],
                                  headers: const {
                                    'User-Agent':
                                        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36 Edg/126.0.0.0',
                                  },
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          //价格
                          Positioned(
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
                                  "￥" + books[index]['price'].toString(),
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //标题
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        width: width,
                        child: Text(
                          maxLines: 1,
                          books[index]['title'],
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        width: width,
                        child: Text(
                          maxLines: 1,
                          books[index]['authorName'],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
