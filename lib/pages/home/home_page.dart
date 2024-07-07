// ignore_for_file: unused_local_variable

import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:e_book/http/dio_instance.dart';
import 'package:e_book/pages/components/my_book_tile.dart';
import 'package:e_book/pages/components/my_search_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> activities = [
    "全部",
    "读书专题",
    "直播活动",
    "名家问答",
    "共读交流",
    "鉴书团",
  ];
  int _value = 0;
  List<Map<String, dynamic>> images = [
    {
      "background":
          "https://img3.doubanio.com/mpic/book-activity-5f72c3983c7545c1910cfd569c2c4a82",
      "title": '误入荆棘丛|纪念卡夫卡逝世100周年'
    },
    {
      "background":
          "https://img1.doubanio.com/mpic/book-activity-9c35a73f74604f7fb3776f1864364489",
      "title": '世界在书中|豆瓣读书2024世界读书日特别报告'
    },
    {
      "background":
          "https://img3.doubanio.com/mpic/book-activity-fa7d714bf3804056b5234ee71a9a9d13",
      "title": '眺望山峦，或凝视虚空：卡夫卡逝世百年纪念对谈｜阿乙×李双志×包慧怡'
    },
    {
      "background":
          "https://img3.doubanio.com/mpic/book-activity-c6fdeac44cd8473f887f17b7c43666c3",
      "title": '从《战争与和平》走向托尔斯泰｜刘文飞×贾行家'
    },
    {
      "background":
          "https://img1.doubanio.com/mpic/book-activity-e41e14ec00644edfa701ababfe9e1ccc",
      "title": '年轻一代热爱的思想家，如何记录当下｜戴锦华×但汉松×王立秋'
    },
  ];
  List<Map<String, dynamic>> books = [
    {
      "price": 12.0,
      "title": "食南之徒",
      "authorName": "作者：马伯庸",
      "cover": "https://img3.doubanio.com/view/subject/s/public/s34823157.jpg"
    },
    {
      "price": 20.0,
      "title": "早安，怪物",
      "authorName": "作者：凯瑟琳·吉尔迪纳",
      "cover": "https://img3.doubanio.com/view/subject/s/public/s34798823.jpg"
    },
    {
      "price": 18.0,
      "title": "读库2403",
      "authorName": "作者：张立宪",
      "cover": "https://img1.doubanio.com/view/subject/s/public/s34865729.jpg"
    },
    {
      "price": 19.0,
      "title": "十八岁出门远行",
      "authorName": "作者：余华",
      "cover": "https://img1.doubanio.com/view/subject/s/public/s34804300.jpg"
    },
    {
      "price": 21.0,
      "title": "我们八月见",
      "authorName": "作者：[哥伦比亚]加西亚·马尔克斯",
      "cover": "https://img1.doubanio.com/view/subject/s/public/s34797230.jpg"
    },
    {
      "price": 30.0,
      "title": "生死结",
      "authorName": "作者：尹学芸",
      "cover": "https://img3.doubanio.com/view/subject/s/public/s34822187.jpg"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: _getBodyUI(),
    );
  }

  Widget _getBodyUI() {
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
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "读书活动",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 150,
                  child: Swiper(
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          //背景图
                          Container(
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    images[index]['background'],
                                    headers: const {
                                      'User-Agent':
                                          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36 Edg/126.0.0.0',
                                    },
                                  ),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          //背景遮罩
                          Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          //文字
                          Container(
                            height: 150,
                            padding: EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //标题
                                Text(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  images[index]['title'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                //专题、时间
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    //专题
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: const Text(
                                        "读书专题",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    //时间
                                    const Text(
                                      "2024-05-31 - 06-10",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    pagination: SwiperPagination(
                      alignment: Alignment.bottomRight,
                      builder: DotSwiperPaginationBuilder(
                        color: Colors.white.withOpacity(0.4),
                        activeColor: Colors.white,
                        size: 8.0,
                        activeSize: 10.0,
                        space: 2.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
            //活动类型
            const SizedBox(
              height: 10,
            ),
            SizedBox(
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
                    children: List.generate(activities.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ChoiceChip(
                          label: Text(activities[index]),
                          selected: _value == index,
                          onSelected: (value) {
                            setState(
                              () {
                                _value = index;
                              },
                            );
                          },
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            //特别推荐
            const SizedBox(
              height: 30,
            ),
            MyBookTile(books: books, height: 160, width: 120),
          ],
        ),
      ),
    );
  }
}
