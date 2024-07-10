import 'package:e_book/pages/book_detail/book_detail_vm.dart';
import 'package:e_book/pages/components/author_tile/my_author_tile.dart';
import 'package:e_book/pages/components/book_detail_tile/my_book_detail_tile.dart';
import 'package:e_book/pages/components/book_reviews/my_book_review_tile.dart';
import 'package:e_book/pages/components/my_book_detail_appbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/book.dart';
import '../components/book_content_tile/my_book_content_tile.dart';

class BookDetailPage extends StatefulWidget {
  final Book book;
  const BookDetailPage({super.key, required this.book});

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  BookDetailViewModel _viewModel = BookDetailViewModel();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(160),
          child: _getAppBarUI(),
        ),
        body: _getBodyUI(),
      ),
    );
  }

  Widget _getAppBarUI() {
    return MyBookDetailAppbar(
      cover: widget.book.cover ?? "",
      subTitle: widget.book.subTitle ?? widget.book.authorName ?? "",
      title: widget.book.title ?? "",
      topActions: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //左侧返回图标
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          //右侧网页链接
          IconButton(
            tooltip: '在线链接',
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.link,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getBodyUI() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MyBookDetailTile(
            data: ["56.00", "269", "8.3"],
            labels: ["定价", "页数", "评分"],
          ),
          const SizedBox(
            height: 25,
          ),
          //内容简介
          Selector<BookDetailViewModel, String?>(
            builder: (context, content, child) {
              return MyBookContentTitle(
                content: content,
                labelTitle: "当前版本有售",
              );
            },
            selector: (_, viewModel) => viewModel.content,
          ),
          const SizedBox(
            height: 20,
          ),
          //作者
          Selector<BookDetailViewModel, List?>(
            builder: (context, authors, child) {
              return MyAuthorTile(
                authors: authors,
              );
            },
            selector: (_, viewModel) => viewModel.authors,
          ),
          const SizedBox(height:10,),
          //书评
          Selector<BookDetailViewModel, List?>(
            builder: (context, reviews, child) {
              return MyBookReview(reviews: reviews,);
            },
            selector: (_, viewModel) => viewModel.reviews,
          ),
          //相似
          
        ],
      ),
    );
  }
}
