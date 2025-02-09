import 'package:e_book/http/spider/spider_api.dart';
import 'package:flutter/foundation.dart';

import '../../model/book.dart';

class DoubanStoreViewModel extends ChangeNotifier {
  List<Book>? _expressBooks; //新书速递
  List<Book>? _weeklyBooks; //一周热门
  List<Book>? _top250Books; //top250

  List<Book>? get expressBooks => _expressBooks;
  List<Book>? get weeklyBooks => _weeklyBooks;
  List<Book>? get top250Books => _top250Books;
  set expressBooks(List<Book>? expressBooks) {
    _expressBooks = expressBooks;
    notifyListeners();
  }

  set weeklyBooks(List<Book>? weeklyBooks) {
    _weeklyBooks = weeklyBooks;
    notifyListeners();
  }

  set top250Books(List<Book>? top250Books) {
    _top250Books = top250Books;
    notifyListeners();
  }
  Future getDouBanStoreData() async{
    expressBooks = await SpiderApi.instance().fetchExpressBooks();
    SpiderApi.instance().fetchDoubanStoreData(
      weeklyBooksCallback:(List<Book> values) => weeklyBooks = values,
      top250BooksCallback:(List<Book> values) => top250Books = values,
    );
  }
}
