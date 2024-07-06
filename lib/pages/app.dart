import 'package:e_book/pages/root/root_page.dart';
import 'package:e_book/pages/theme/dark_theme.dart';
import 'package:e_book/pages/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

Size get designSize {
  final firstView = WidgetsBinding.instance.platformDispatcher.views.first;
  final logicalShortesSize =
      firstView.physicalSize.shortestSide / firstView.devicePixelRatio;
  final logicalLongestSize =
      firstView.physicalSize.longestSide / firstView.devicePixelRatio;
  const scaleFactor = 0.95;
  return Size(
      logicalShortesSize * scaleFactor, logicalLongestSize * scaleFactor);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: designSize,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: Provider.of<ThemeProvider>(context,listen: true).themeData,
          darkTheme: darkMode,
          home: const RootPage(),
        );
      },
    );
  }
}
