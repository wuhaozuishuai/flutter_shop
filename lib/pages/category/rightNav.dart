import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../provider/child_category.dart';
import '../../service/service_method.dart';
import '../../model/category.dart';
import '../../provider/category_goods_list.dart';
import '../../model/category_goods_list.dart';
//TODO 右侧二级导航
class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {

  // List list = ['类别1','类别2','类别三','类别4','类别555','类别555','类别555'];

  @override
  Widget build(BuildContext context) {
    List list =Provider.of<ChildCategory>(context).childCategoryList;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
                  width:1,
                  color: Colors.black12
              )
          )
      ),
      height: ScreenUtil().setHeight(80),
      width: ScreenUtil().setWidth(570),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,//设置为横向
        itemCount: list.length,
        itemBuilder: (context,index){
          return _rightInkWell(index,list[index]);
        },
      ),
    );
  }

  Widget _rightInkWell(int index,BxMallSubDto item){
    bool isClick = false;
    isClick=(index==Provider.of<ChildCategory>(context).childIndex)?true:false;
    return InkWell(
      //点击二级菜单
      onTap: (){
        Provider.of<ChildCategory>(context,listen: false).changeChildIndex(index,item.mallSubId);
        _getGoodsList(item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 15, 5, 10),

        child: Text(
          item.mallSubName,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(25),
              color: isClick?Colors.orangeAccent:Colors.black
          ),
        ),
      ),
    );
  }

  //TODO 获取二级商品列表
  void _getGoodsList( String categorySubId) async{
    var data = {
      'categoryId':Provider.of<ChildCategory>(context,listen: false).categoryId,
      'categorySubId':categorySubId,
      'page':1
    };
    await request('getMallGoods',formData: data).then((value){
      var data = json.decode(value.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      print('>>>>>>>>>>>>>>>>>>>>调用接口获取数据');
      if (goodsList == null) {
        Provider.of<CategoryGoodsListProvider>(context,listen: false).getGoodsList([]);
      }else{
        Provider.of<CategoryGoodsListProvider>(context,listen: false).getGoodsList(goodsList.data);
      }

    });
  }

}