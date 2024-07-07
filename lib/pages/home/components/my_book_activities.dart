import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

import '../../../model/activity.dart';

class MyBookActivities extends StatelessWidget {
  final List<Activity> activities;
  const MyBookActivities({super.key,required this.activities});

  @override
  Widget build(BuildContext context) {
    return Column(
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
            itemCount: activities?.length ?? 0,
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
                            activities[index].cover??"",
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
                          activities[index].title??"",
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
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text(
                                activities[index].label??"",
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
                             Text(
                              activities[index].time??"",
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
    );
  }
}
