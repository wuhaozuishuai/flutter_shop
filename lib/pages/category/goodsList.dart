import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/category_goods_list.dart';
import 'package:flutter_shop/service/service_method.dart';
// import 'package:flutter_shop/provider/child_category.dart';
import 'package:provider/provider.dart';
import '../../provider/category_goods_list.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../../provider/child_category.dart';
import 'package:fluttertoast/fluttertoast.dart';

//TODO 商品列表，可以上拉加载
class CategoryGoodsList extends StatefulWidget {

  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {

  @override
  Widget build(BuildContext context) {
    List list = [];
    list =Provider.of<CategoryGoodsListProvider>(context).goodsList;
    GlobalKey _globalKey = GlobalKey();
    var scrollController = new ScrollController();
    print('测试空数据问题');
    print(list);
    try{
        if(Provider.of<ChildCategory>(context,listen: false).page==1){
          //重置列表为顶部
          scrollController.jumpTo(0);
        }
    }catch(e){
        print('进入页面第一次初始化：${e}');
    }
    if (list != null) {
      //Expanded可伸缩组件，用于解决不同手机型号长度溢出问题
      return Expanded(
        child: Container(
          width: ScreenUtil().setWidth(570),
          // height: ScreenUtil().setHeight(1050),
          child:EasyRefresh(
            child: ListView.builder(
              controller: scrollController,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return _ListWidget(list,index);
              },
            ),
            footer: ClassicalFooter(
              key: _globalKey,
              bgColor: Colors.white,
              textColor: Colors.deepOrange,
              noMoreText: Provider.of<ChildCategory>(context,listen: false).noMoreText,
              loadText: '加载中',
            ),
              onLoad:()async{
                print('kaishijiazai ');
                // var formData = {'page': page};
                _getMoreList();

              }
          )



        ),
      );
    } else {
      return Text('暂无此类数据，敬请期待');
    }
  }
  //TODO 商品图片
  Widget _goodsImage(list,index){
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(list[index].image),
    );
  }
  //TODO 商品名称
  Widget _goodsName(list,index){
    return Container(
      padding: EdgeInsets.all(5),
      width: ScreenUtil().setWidth(370),
      child: Text(
        list[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }
  //TODO 商品价格
  Widget _goodPrice(list,index){
    return Container(
        width: ScreenUtil().setWidth(370),
        margin: EdgeInsets.only(top: 20),
        child: Row(
          children: [
            Text(
              '价格：￥${list[index].presentPrice}',
              style: TextStyle(color:Colors.orangeAccent,fontSize: ScreenUtil().setSp(30)),
            ),
            Text('￥${list[index].oriPrice}',
              style: TextStyle(color: Colors.black26,decoration: TextDecoration.lineThrough),
            )
          ],
        )
    );
  }
  //TODO 组合
  Widget _ListWidget(List list,int index){
    return InkWell(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 1,
                    color: Colors.black12
                )
            )
        ),
        child: Row(
          children: [
            _goodsImage(list,index),
            Column(
              children: [
                _goodsName(list,index),
                _goodPrice(list,index)
              ],
            )
          ],
        ),
      ),
    );
  }


  //TODO 获取分类商品列表
  void _getMoreList() async{
    Provider.of<ChildCategory>(context,listen: false).addPage();

    var data = {
      'categoryId': Provider.of<ChildCategory>(context,listen: false).categoryId,
      'categorySubId':Provider.of<ChildCategory>(context,listen: false).subId,
      'page':Provider.of<ChildCategory>(context,listen: false).page
    };
    await request('getMallGoods',formData: data).then((value){
      var data = json.decode(value.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      print('>>>>>>>>>>>>>>>>>>>>');
      print(goodsList);
      if(goodsList==null){
        Fluttertoast.showToast(
            msg: "This is Center Short Toast",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Provider.of<ChildCategory>(context,listen: false).changeNoMore('暂无更多！');
      }else{
        Provider.of<CategoryGoodsListProvider>(context,listen: false).getMoreList(goodsList.data);
      }

    });
  }
}

