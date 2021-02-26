import 'package:flutter/material.dart';
import './pages/index_page.dart';
import 'package:provider/provider.dart';
import './provider/counter.dart';
import './provider/child_category.dart';
import './provider/category_goods_list.dart';
import 'package:fluro/fluro.dart';
void main() {
  // runApp(ChangeNotifierProvider<Counter>.value(
  //   value:Counter(0),
  //   child: MyApp(),
  // )
  // );
  runApp(
          MultiProvider(
        providers: [
          ChangeNotifierProvider<ChildCategory>.value(value: ChildCategory()),
          ChangeNotifierProvider<Counter>.value(value: Counter(0)),
          ChangeNotifierProvider<CategoryGoodsListProvider>.value(value: CategoryGoodsListProvider()),
          // Provider<Counter>(create: (_)=>Counter(0))
        ],
        child: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 初始化传入宽高

    return Container(
              child: MaterialApp(
                title: '百姓生活家',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(primaryColor: Colors.orangeAccent),
                home: IndexPage(),
              ),
            );

            }
}

