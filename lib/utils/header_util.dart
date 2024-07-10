import 'dart:math';

class HeaderUtil {
  static final _random = Random();
  static const List<String> _userAgent = [
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36 Edg/126.0.0.0',
  ];
  static Map<String, String> randomHeader() {
    return {"User-Agent": _userAgent[_random.nextInt(_userAgent.length)]};
  }
}
