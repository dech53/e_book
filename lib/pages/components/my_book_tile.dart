import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_book/model/book.dart';
import 'package:e_book/pages/components/book_tile/my_book_tile_item.dart';
import 'package:e_book/pages/components/book_tile/my_book_tile_item_skeleton.dart';
import 'package:flutter/material.dart';

class MyBookTile extends StatelessWidget {
  final List<Book>? books;
  final double? height;
  final double? width;
  final bool? showPrice;
  final String title;
  final bool? showRate;
  final Function(Book book)? itemTap;
  const MyBookTile(
      {super.key,
       this.books,
       this.height,
       this.width,
      this.showPrice = false,required this.title,  this.showRate, this.itemTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,
          ),
        ),
        //书籍信息
        const SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              books?.length??5,
              (index) {
                if(books==null){
                  return  MyBookTileItemSkeleton(width: width,height: height,);
                }
                return GestureDetector(
                  onTap: (){
                    if(books?[index] == null) return;
                    itemTap?.call(books![index]);
                  },
                  child: MyBookTileItem(book: books![index],
                  width: width,
                  height: height,
                  showPrice: showPrice,
                  showRate: showRate,),
                );
              }),
            ),
          ),
      ],
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
