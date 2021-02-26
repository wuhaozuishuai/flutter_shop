import 'package:flutter/material.dart';
import '../model/category_goods_list.dart';

class CategoryGoodsListProvider with ChangeNotifier{
  List<CategoryListData> _goodsList = [];
  //点击大类时更换商品列表
  getGoodsList(List<CategoryListData> list){
    _goodsList = list;
    notifyListeners();
  }
  getMoreList(List<CategoryListData> list){
      _goodsList.addAll(list);
      notifyListeners();
  }
  get goodsList => _goodsList;
}