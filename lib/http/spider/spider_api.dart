import 'dart:async';

import 'package:dio/dio.dart';
import 'package:e_book/http/dio_instance.dart';
import 'package:e_book/http/spider/api_string.dart';
import 'package:e_book/model/activity.dart';
import 'package:e_book/model/book.dart';
import 'package:e_book/model/types.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

class SpiderApi {
  static SpiderApi? _instance;
  SpiderApi._();
  static SpiderApi instance() {
    return _instance ??= SpiderApi._();
  }

  void fetchDoubanStoreData({
    Function(List<Book> values)? weeklyBooksCallback,
    Function(List<Book> values)? top250BooksCallback,
  }) async {
    String htmlStr = await DioInstance.instance()
        .getString(path: ApiString.bookDoubanHomeUrl);
    Document document = parse(htmlStr);
    if (weeklyBooksCallback != null) {
      weeklyBooksCallback.call(_parseWeeklyBooks(document));
    }
    ;
    if (top250BooksCallback != null) {
      top250BooksCallback.call(_parseTop250Books(document));
    }
    ;
  }

  Future<List<Book>> fetchExpressBooks() async {
    Response response = await DioInstance.instance().get(
        path: ApiString.bookExpressJsonUrl,
        param: {"tag": BookExpressTag.all.value});
    Document document = parse(response.data['result']);
    return _parseExpressBooks(document);
  }

  Future<List<Activity>> fetchBookActivities(int? kind) async {
    Map<String, dynamic>? param = kind == null ? null : {"kind": kind};
    Response response = await DioInstance.instance()
        .get(path: ApiString.bookActivitiesJsonUrl, param: param);
    String htmlStr = response.data['result'];
    Document document = parse(htmlStr);
    return parseBookActivities(document);
  }

  Future fetchHomeData({
    Function(List<Activity> values)? activitiesCallback,
    Function(List<String> values)? activitiesLabelCallback,
    Function(List<Book> values)? booksCallback,
  }) async {
    String htmlStr = await DioInstance.instance()
        .getString(path: ApiString.bookDoubanHomeUrl);
    Document document = parse(htmlStr);
    if (activitiesCallback != null) {
      activitiesCallback.call(parseBookActivities(document));
    }
    if (activitiesLabelCallback != null) {
      List<Element> spanEls =
          document.querySelectorAll('.books-activities .hd .tags .item');
      List<String> labels = [];
      for (Element span in spanEls) {
        labels.add(span.text.trim());
      }
      activitiesLabelCallback.call(labels);
    }
    //解析书籍
    if (booksCallback != null) {
      booksCallback.call(_parseExpressBooks(document));
    }
  }

  List<Activity> parseBookActivities(Document document) {
    List<Element> aEls =
        document.querySelectorAll(".books-activities .book-activity");
    List<Activity> activities = [];
    for (Element a in aEls) {
      String href = a.attributes['href']?.trim() ?? "";
      String cover = ApiString.getBookActivityCover(a.attributes['style']);
      String title = a.querySelector('.book-activity-title')?.text.trim() ?? "";
      String label = a.querySelector('.book-activity-label')?.text.trim() ?? "";
      String time =
          a.querySelector('.book-activity-time time')?.text.trim() ?? "";
      activities.add(
        Activity(
          url: href,
          cover: cover,
          title: title,
          label: label,
          time: time,
        ),
      );
    }
    return activities;
  }

  List<Book> _parseExpressBooks(Document document) {
    Element ulEl =
        document.querySelectorAll('.books-express .bd .slide-item')[1];
    List<Element> liEls = ulEl.querySelectorAll('li');
    List<Book> books = [];
    for (Element li in liEls) {
      //解析id
      Element? a = li.querySelector('.cover a');
      String id =
          ApiString.getId(a?.attributes['href'], ApiString.bookIdRegExp);
      String cover = a?.querySelector('img')?.attributes['src'] ?? "";

      books.add(Book(
        id: id,
        cover: cover,
        title: li.querySelector('.info .title')?.text.trim() ?? "",
        authorName: li.querySelector('.info .author')?.text.trim() ?? "",
      ));
    }
    return books;
  }

  List<Book> _parseWeeklyBooks(Document document) {
    List<Element> liEls = document.querySelectorAll(".popular-books .bd ul li");
    return liEls.map((li) {
      //封面
      String? cover = li.querySelector(".cover img")?.attributes["src"];
      //标题
      Element? aEl = li.querySelector(".title a");
      String? title = aEl?.innerHtml.trim();
      //ID
      String? id =
          ApiString.getId(aEl?.attributes['href'], ApiString.bookIdRegExp);
      //作者
      String? authorName = li.querySelector(".author")?.innerHtml.trim() ?? "";
      authorName = authorName.replaceFirst("作者:", "");
      //副标题
      String? subTitle;
      if (title != null && title.isEmpty) {
        List titles = title.split(':');
        if (titles.length > 1) {
          titles = titles[0];
          subTitle = titles[1];
        } else {
          subTitle = authorName;
        }
      }
      //评分
      double rate = parseRate(li.querySelector(".average-rating")?.text.trim());
      return Book(
          id: id,
          title: title,
          authorName: authorName,
          subTitle: subTitle,
          rate: rate,
          cover: cover);
    }).toList();
  }

  double parseRate(String? rateStr) {
    if (rateStr == null || rateStr.isEmpty) return 0.0;
    try {
      return double.parse(rateStr);
    } catch (_) {
      return 0.0;
    }
  }

  List<Book> _parseTop250Books(Document document) {
    List<Element> dlEls = document.querySelectorAll("#book_rec dl");
    return dlEls.map((dl) {
      Element aEl = dl.children[0].children[0];
      String? cover = aEl?.children[0].attributes['src'];
      String? id =
          ApiString.getId(aEl.attributes['href'], ApiString.bookIdRegExp);

      return Book(
        id: id,
        title: dl.children[1].children[0].text.trim(),
        cover: cover,
      );
    }).toList();
  }
}
