
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../pages/category/leftNav.dart';
import '../pages/category/rightNav.dart';
import '../pages/category/goodsList.dart';
//TODO 分类页面
class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类')
      ),
      body: Container(
        child: Row(
          children: [
            LeftCategoryNav(),
            Column(
              children: [
                RightCategoryNav(),
                CategoryGoodsList()
              ],
            )
          ],
        ),
      ),
    );
  }


}












