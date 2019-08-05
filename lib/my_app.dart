import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/i18n.dart';
import 'page_index.dart';

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Store.setStoreCtx(context); // 初始化数据层
  }

  @override
  Widget build(BuildContext context) {
    Store.value<ConfigModel>(context)
      ..$getTheme()
      ..$getLocal();

    return Store.connect<ConfigModel>(builder: (context, child, model) {
      return MaterialApp(

          /// 任务管理器显示的标题
          title: "Flutter Demo",

          /// 您可以通过配置ThemeData类轻松更改应用程序的主题
          theme: AppTheme.getThemeData(model.theme),

          /// 右上角显示一个debug的图标
          debugShowCheckedModeBanner: false,

          /// 主页
          home: SplashScreenPage(),

          /// localizationsDelegates 列表中的元素时生成本地化集合的工厂
          localizationsDelegates: [
            // 为Material Components库提供本地化的字符串和其他值
            GlobalMaterialLocalizations.delegate,

            // 定义widget默认的文本方向，从左往右或从右往左
            GlobalWidgetsLocalizations.delegate,

            S.delegate,

            /// 解决 ‘使用CupertinoAlertDialog 报 'alertDialogLabel' was called on null’ 的BUG
            const FallbackCupertinoLocalisationsDelegate(),
          ],

          ///
          supportedLocales: S.delegate.supportedLocales,

          ///
          locale: mapLocales[SupportLocale.values[model.local]],

          /// 不存对应locale时，默认取值Locale('zh', 'CN')
          localeResolutionCallback:
              S.delegate.resolution(fallback: const Locale('zh', 'CN')),

          /// 路由
          routes: <String, WidgetBuilder>{
            '/shopCart': (BuildContext context) => IndexPage(index: 2)
          });
    });
  }
}