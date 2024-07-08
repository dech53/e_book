import 'package:e_book/model/book.dart';
import 'package:e_book/pages/components/my_book_tile.dart';
import 'package:e_book/pages/components/my_search_tile.dart';
import 'package:e_book/pages/douban_store/douban_store_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoubanStorePage extends StatefulWidget {
  const DoubanStorePage({super.key});

  @override
  State<DoubanStorePage> createState() => _DoubanStorePageState();
}

class _DoubanStorePageState extends State<DoubanStorePage> {
  final DoubanStoreViewModel _viewModel = DoubanStoreViewModel();
  @override
  void initState() {
    super.initState();
    _viewModel.getDouBanStoreData();
  }
  @override
  Widget build(BuildContext context) {
    Color surf = Theme.of(context).colorScheme.surface;
    return ChangeNotifierProvider.value(
      value: _viewModel,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 0,
            backgroundColor: surf,
            surfaceTintColor: surf,
          ),
          backgroundColor: surf,
          body: _getBodyUI(),
        );
      },
    );
  }

  Widget _getBodyUI() {
    return SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(right: 15, top: 15, left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          //搜索
          const MySearchTile(),
          const SizedBox(
            height: 30,
          ),
          //新书速递
          Selector<DoubanStoreViewModel, List<Book>?>(
            builder: (context, books, child) {
              return MyBookTile(books: books,title: '新书速递',width: 120,height: 160,);
            },
            selector: (_, viewModel) => viewModel.expressBooks,
          ),
          //一周热门
          const SizedBox(height: 30,),
          Selector<DoubanStoreViewModel, List<Book>?>(
            builder: (context, books, child) {
              return MyBookTile(books: books,title: '一周热门图书馆',width: 120,height: 160,showRate: true,);
            },
            selector: (_, viewModel) => viewModel.weeklyBooks,
          ),
          //top250
          const SizedBox(height: 30,),
          Selector<DoubanStoreViewModel, List<Book>?>(
            builder: (context, books, child) {
              return MyBookTile(books: books,title: '豆瓣阅读Top250',width: 120,height: 160,);
            },
            selector: (_, viewModel) => viewModel.top250Books,
          ),
        ],
      ),
    ));
  }
}
