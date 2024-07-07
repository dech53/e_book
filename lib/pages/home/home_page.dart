// ignore_for_file: unused_local_variable

import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:e_book/http/dio_instance.dart';
import 'package:e_book/model/book.dart';
import 'package:e_book/pages/components/my_book_tile.dart';
import 'package:e_book/pages/components/my_search_tile.dart';
import 'package:e_book/pages/home/components/my_book_activities.dart';
import 'package:e_book/pages/home/components/my_book_activity_labels.dart';
import 'package:e_book/pages/home/home_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../../model/activity.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _viewModel = HomeViewModel();
  @override
  void initState() {
    super.initState();
    _viewModel.getHomePageData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: _getBodyUI(),
    );
  }

  Widget _getBodyUI() {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      builder: (context, child) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                //头像行
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "欢迎..",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage('images/headerimg.jpg'),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                //搜索
                MySearchTile(
                  bookshelfTap: () {},
                ),
                const SizedBox(
                  height: 30,
                ),
                //读书活动
                Selector<HomeViewModel, List<Activity>?>(
                  builder: (context, List<Activity>? activities, child) {
                    if (activities == null) {
                      return const SizedBox();
                    }
                    return MyBookActivities(activities: activities);
                  },
                  selector: (_, viewModel) => viewModel.activities,
                ),
                //活动类型
                const SizedBox(
                  height: 10,
                ),
                Selector<HomeViewModel, List<String>?>(
                  builder: (context, labels, child) {
                    if (labels == null) {
                      return const SizedBox();
                    }
                    return MyBookActivityLabels(labels: labels);
                  },
                  selector: (_, viewModel) => viewModel.activityLabels,
                ),
                //特别推荐
                const SizedBox(
                  height: 30,
                ),
                Selector<HomeViewModel, List<Book>?>(
                  builder: (context, books, child) {
                    if (books == null) {
                      return const SizedBox();
                    }
                    return MyBookTile(books: books, height: 160, width: 120);
                  },
                  selector: (_, viewModel) => viewModel.books,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
