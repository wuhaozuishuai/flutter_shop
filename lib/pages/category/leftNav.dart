//TODO 左侧侧边导航
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

//TODO 左侧侧边导航

class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {

  List list = [];
  var listIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    _getCategory();//获取list数据
    _getGoodsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
          border: Border(
              right: BorderSide(
                  width: 2,color: Colors.black12
              )
          )
      ),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _leftInkWell(index);
        },
      ),
    );
  }

  Widget _leftInkWell(int index){
    bool isClick = false;
    isClick = (index==listIndex)?true:false;
    return InkWell(
      onTap: (){
        setState(() {
          listIndex = index;

        });
        var childList = list[index].bxMallSubDto;
        var categoryId = list[index].mallCategoryId;
        Provider.of<ChildCategory>(context,listen: false).getChildCategory(childList,categoryId);
        _getGoodsList(categoryId: categoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(70),
        padding: EdgeInsets.only(left: 10,top: 20),
        decoration: BoxDecoration(
            color:isClick? Colors.grey:Colors.white,
            border: Border(
                bottom: BorderSide(width: 1,color: Colors.black12)
            )
        ),
        child: Text(list[index].mallCategoryName,style: TextStyle(fontSize: ScreenUtil().setSp(20)),),
      ),
    );
  }


  //获取分类
  void _getCategory() async{
    await request('getCategory').then((value){
      var data = json.decode(value);
      CategoryModel category = CategoryModel.fromJson(data);
      setState(() {
        list = category.data;
      });
      Provider.of<ChildCategory>(context,listen: false).getChildCategory(list[0].bxMallSubDto,list[0].mallCategoryId);

      // list.data.forEach((element)=>print(element));
    });
  }
  //TODO 获取分类商品列表
  void _getGoodsList({ String categoryId}) async{
    var data = {
      'categoryId':categoryId == null?'4':categoryId,
      'categorySubId':'',
      'page':1
    };
    await request('getMallGoods',formData: data).then((value){
      var data = json.decode(value.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      print('>>>>>>>>>>>>>>>>>>>>');
      print(goodsList);
      if(goodsList==null){
        Provider.of<CategoryGoodsListProvider>(context,listen: false).getGoodsList([]);
      }else{
        Provider.of<CategoryGoodsListProvider>(context,listen: false).getGoodsList(goodsList.data);
      }

    });
  }
}