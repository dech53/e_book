import 'package:e_book/http/dio_instance.dart';
import 'package:e_book/http/spider/api_string.dart';
import 'package:e_book/model/activity.dart';
import 'package:e_book/model/book.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

class SpiderApi {
  static SpiderApi? _instance;
  SpiderApi._();
  static SpiderApi instance() {
    return _instance ??= SpiderApi._();
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
      booksCallback.call(parseHomeBooks(document));
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

  List<Book> parseHomeBooks(Document document) {
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
}
