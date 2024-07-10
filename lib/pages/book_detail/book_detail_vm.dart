import 'package:e_book/model/book.dart';
import 'package:flutter/foundation.dart';

class BookDetailViewModel extends ChangeNotifier {
  Book? _book;
  String? _content =
      "ZUI贪吃的大汉使者唐蒙,来到了ZUI会吃的南越之国。了ZUI会吃的南越之国。这里食材丰富,简直就是饕餮之徒的梦想之地了ZUI会吃的南越之国。这里食材丰富,简直就是饕餮之徒的梦想之地了ZUI会吃的南越之国。这里食材丰富,简直就是饕餮之徒的梦想之地了ZUI会吃的南越之国。这里食材丰富,简直就是饕餮之徒的梦想之地这里食材丰富,简直就是饕餮之徒的梦想之地。然而,在美食背后,却涌动着南北对峙、族群隔阂、权位争斗、国策兴废……种种波谲云诡,竟比岭南食材的风味更加复杂。这个懒散的大汉使者,身陷岭南的政争漩涡。他唯一能信赖的伙伴,只有食物;唯一的破局之法，只有追求极致美食的心。谁都没想到，那一缕微妙滋味，竟关乎大汉与南越国运，乃至于整个中华版图……";
  List? _authors = ['罗欣'];
  List? _reviews = ['如果一个人总是能带来美味的食物，他自然会赢得其他人的敬爱，这一点人类和其他动物并无区别。'];
  Book? get book => _book;
  String? get content => _content;
  List? get authors => _authors;
  List? get reviews => _reviews;
  set book(Book? book) {
    _book = book;
    notifyListeners();
  }

  set reviews(List? reviews) {
    _reviews = reviews;
    notifyListeners();
  }

  set authors(List? authors) {
    _authors = authors;
    notifyListeners();
  }

  set content(String? content) {
    _content = content;
    notifyListeners();
  }
}
