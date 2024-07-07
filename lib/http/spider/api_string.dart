class ApiString {
  static const String bookDoubanHomeUrl = "https://book.douban.com/";
  static const String bookActivityCoverReg = r"https:.*(?='\))";
  static const String bookIdRegExp = r'(?<=/subject/)\d+(?=/)';
  static String getBookActivityCover(String? style) {
    //正则表达匹配属性
    if (style == null || style.isEmpty) return "";
    return RegExp(bookActivityCoverReg).stringMatch(style) ?? "";
  }

  static String getId(String? content,String reg) {
    if(content==null||content.isEmpty) return "";
    return RegExp(reg).stringMatch(content) ?? "";
  }
}
