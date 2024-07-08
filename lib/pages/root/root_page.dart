import 'package:e_book/pages/douban_store/douban_store_page.dart';
import 'package:e_book/pages/ebook_store/ebook_store_page.dart';
import 'package:e_book/pages/home/home_page.dart';
import 'package:e_book/pages/my_book/my_book_page.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:line_icons/line_icons.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _index = 1;

  List rootApp = [
    {"icon": LineIcons.home, "title": "首页"},
    {"icon": LineIcons.book, "title": "读书"},
    {"icon": LineIcons.shoppingBag, "title": "书城"},
    {"icon": LineIcons.heart, "title": "我的"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      bottomNavigationBar: _getBottomNavigator(context),
      body: LazyLoadIndexedStack(
        index: _index,
        children: [
          HomePage(),
          DoubanStorePage(),
          EbookStorePage(),
          MyBookPage(),
        ],
      ),
    );
  }

  Widget _getBottomNavigator(BuildContext context) {
    return SalomonBottomBar(
      currentIndex: _index,
      onTap: (index) {
        setState(() {
          _index = index;
        });
      },
      items: List.generate(
        rootApp.length,
        (index) {
          return SalomonBottomBarItem(
            selectedColor: Theme.of(context).colorScheme.onSurface,
            unselectedColor: Theme.of(context).colorScheme.inversePrimary,
            icon: Icon(rootApp[index]['icon']),
            title: Text(
              rootApp[index]['title'],
            ),
          );
        },
      ),
    );
  }
}
