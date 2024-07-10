import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_book/utils/header_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyBookDetailAppbar extends StatefulWidget {
  final Widget? topActions;
  final String cover;
  final String subTitle;
  final String title;
  const MyBookDetailAppbar({super.key, this.topActions,required this.cover,required this.subTitle,required this.title});

  @override
  State<MyBookDetailAppbar> createState() => _MyBookDetailAppbarState();
}

class _MyBookDetailAppbarState extends State<MyBookDetailAppbar> {
  final GlobalKey _key = GlobalKey();
  double? _coverWidth;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPersistentFrameCallback((duration){
      RenderBox? box = _key.currentContext?.findRenderObject() as RenderBox?;
      if(_coverWidth==null){
        _coverWidth = box?.size.width;
        setState(() {
          
        });
      }
    });
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: Stack(
        children: [
          //背景封面
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  widget.cover,
                  headers: HeaderUtil.randomHeader(),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          //遮罩
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
            ),
          ),

          SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                //模糊背景
                BlurryContainer(
                  borderRadius: BorderRadius.zero,
                  child: Container(),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //leading action
                      widget.topActions??const SizedBox(),
                      //left leading action
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 15, left: 15),
                          child: Stack(
                            children: [
                              //书籍封面
                              AspectRatio(
                                aspectRatio: 3 / 4,
                                key: _key,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        widget.cover,
                                        headers: HeaderUtil.randomHeader(),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: _coverWidth??0),
                                child: _getTitleUI(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getTitleUI() {
    return Padding(
      padding: EdgeInsets.only(left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //书籍标题
          Text(
            widget.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onPrimary),
          ),
          //书籍副标题
          const SizedBox(
            height: 6,
          ),
          Text(
            widget.subTitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.onPrimary),
          ),
        ],
      ),
    );
  }
}
