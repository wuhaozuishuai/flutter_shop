import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> _childCategoryList= [];
  //子类高亮索引
  int childIndex = 0;
  //初始大类id
  String categoryId ='4';
  //小类
  String subId = '';
  //页数
  int page = 1;
  //显示没有数据的提示文本
  String noMoreText = '';
  //导航切换
  getChildCategory(List<BxMallSubDto> list,String id){
    //切换导航时重置二级导航索引
    childIndex = 0;
    categoryId = id;
    noMoreText = '';
    page = 1;
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '';
    all.mallCategoryId = '00';
    all.comments = null;
    all.mallSubName = '全部';
    _childCategoryList = [all];
    _childCategoryList.addAll(list);
    // _childCategoryList = list;
    notifyListeners();
  }
  //改变二级菜单
  changeChildIndex(index,String id){
    subId = id;
    childIndex = index;
    noMoreText = '';
    page = 1;
    notifyListeners();
  }

  //增加page的方法
  addPage(){
    page++;
    // notifyListeners();
  }
  //change
  changeNoMore(String text){
    noMoreText = text;
    notifyListeners();
  }
  get childCategoryList => _childCategoryList;
}