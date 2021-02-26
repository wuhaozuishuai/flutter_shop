//首页

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

//混入状态保持
class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  int page = 1;
  List<Map> hotGoodsList = [];
  GlobalKey _globalKey = GlobalKey();
  //混入状态保持需要重写
  @override
  bool get wantKeepAlive => true;

  String homePageContent = '正在获取数据';
  @override
  void initState() {
    // TODO: implement initState初始化状态 不初始化的原因是因为futureBuilder
    //加载首页数据
    // _getHotGoods();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('百姓生活家'),
        ),
        body: FutureBuilder(
          future: request('homePageContent',
              formData: {'lon': '115.45454', 'lat': '56.15555'}),
          builder: (context, snapshot) {
            // 判断是否存在值
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString());
              // 将map解析为list
              List<Map> swiper = (data['data']['slides'] as List).cast();
              List<Map> navigator = (data['data']['category'] as List).cast();
              String adPicture =
                  data['data']['advertesPicture']['PICTURE_ADDRESS'];
              String leaderImage = data['data']['shopInfo']['leaderImage'];
              String leaderPhone = data['data']['shopInfo']['leaderPhone'];
              List<Map> recommendList =
                  (data['data']['recommend'] as List).cast();
              String floot1Title = data['data']['floor1Pic']['PICTURE_ADDRESS'];
              String floot2Title = data['data']['floor2Pic']['PICTURE_ADDRESS'];
              String floot3Title = data['data']['floor3Pic']['PICTURE_ADDRESS'];
              List<Map> floor1 = (data['data']['floor1'] as List).cast();
              List<Map> floor2 = (data['data']['floor2'] as List).cast();
              List<Map> floor3 = (data['data']['floor3'] as List).cast();

              return EasyRefresh(
                  footer: ClassicalFooter(
                    key: _globalKey,
                    bgColor: Colors.white,
                    textColor: Colors.deepOrange,
                    noMoreText: 'dsa',
                    loadText: '加载中',

                  ),
                  child: ListView(
                    children: <Widget>[
                      SwiperDiy(swperDateList: swiper),
                      TopNavigator(navigatorList: navigator),
                      Adbanner(adPicture: adPicture),
                      LeaderPhone(
                          leaderImage: leaderImage, leaderPhone: leaderPhone),
                      Recommend(
                        recommendList: recommendList,
                      ),
                      FloorTitle(
                        picture_address: floot1Title,
                      ),
                      FloorContent(
                        floorGoodList: floor1,
                      ),
                      FloorTitle(
                        picture_address: floot2Title,
                      ),
                      FloorContent(
                        floorGoodList: floor2,
                      ),
                      FloorTitle(
                        picture_address: floot3Title,
                      ),
                      FloorContent(
                        floorGoodList: floor3,
                      ),
                      _hotGoods()
                    ],
                  ),
                  onLoad:()async{
                    print('kaishijiazai ');
                    var formData = {'page': page};
                    await request('homePageBelowConten', formData: formData).then((value) {
                      var data = json.decode(value.toString());
                      List<Map> newGoodsList = (data['data'] as List).cast();
                      setState(() {
                        hotGoodsList.addAll(newGoodsList);
                        page++;
                      });
                    });
                  }
              );

            } else {
              return Center(
                child: Text('55445'),
              );
            }
          },
        ));
  }

  // void _getHotGoods() {
  //   var formData = {'page': page};
  //   request('homePageBelowConten', formData: formData).then((value) {
  //     var data = json.decode(value.toString());
  //     List<Map> newGoodsList = (data['data'] as List).cast();
  //     setState(() {
  //       print(newGoodsList);
  //       hotGoodsList.addAll(newGoodsList);
  //       print(newGoodsList);
  //       page++;
  //     });
  //   });
  // }

  //TODO 火爆专区标题
  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10),
    alignment: Alignment.center,
    color: Colors.transparent,
    padding: EdgeInsets.all(5),
    child: Text('火爆专区'),
  );

  //TODO 火爆专区主体
  Widget _wrapList() {
    if (hotGoodsList.length != null) {
      List<Widget> listWidget = hotGoodsList.map((e) {
        return InkWell(
          onTap: () {},
          child: Container(
            width: ScreenUtil().setWidth(370),
            color: Colors.white,
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(bottom: 3),
            child: Column(
              children: [
                Image.network(e['image'], width: ScreenUtil().setWidth(368)),
                Text(
                  e['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
                ),
                Row(
                  children: [
                    Text('￥${e['mallPrice']}',),
                    Text(
                      '￥${e['price']}',
                      style: TextStyle(
                          color: Colors.black26,
                          decoration: TextDecoration.lineThrough),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }).toList();

      return Wrap(
        //流式布局
        spacing: 2, //每一行两列
        children: listWidget,
      );
    } else {
      return Text('暂无数据');
    }
  }

  Widget _hotGoods() {
    return Container(
      child: Column(
        children: [hotTitle, _wrapList()],
      ),
    );
  }
}

//TODO 首页轮播组件
class SwiperDiy extends StatelessWidget {
  final List swperDateList;
  //构造函数
  SwiperDiy({this.swperDateList});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        //swiper构造器
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            "${swperDateList[index]['image']}",
            fit: BoxFit.cover,
          );
        },
        itemCount: 3,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

//TODO 首页导航
class TopNavigator extends StatelessWidget {
  final List navigatorList;
  TopNavigator({this.navigatorList});

  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      //可以接受单击事件的组件
      onTap: () {
        print('的规范地方');
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'], width: ScreenUtil().setWidth(95)),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (this.navigatorList.length > 10) {
      this.navigatorList.removeRange(10, this.navigatorList.length);
    }
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(2.65),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5, //一行5个
        padding: EdgeInsets.all(5),
        children: navigatorList.map((item) {
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

//TODO 小广告组件
class Adbanner extends StatelessWidget {
  final String adPicture;
  Adbanner({this.adPicture});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture),
    );
  }
}

//TODO 点击图片拨打电话
class LeaderPhone extends StatelessWidget {
  final String leaderImage;
  final String leaderPhone;

  LeaderPhone({this.leaderImage, this.leaderPhone});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _lanuncher,
        child: Image.network(leaderImage),
      ),
    );
  }

  //使用插件拨打电话
  //FIXME 此处存在问题，抛出异常
  void _lanuncher() async {
    String url = 'tel:17353295391'; //拨打电话地址
    // String url = 'tel:'+leaderPhone;//拨打电话地址
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'url不能进行访问';
    }
  }
}

//TODO 商品推荐
class Recommend extends StatelessWidget {
  final List recommendList;
  Recommend({this.recommendList});

  //头部标题组件
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10, 2, 0, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.black12),
        ),
      ),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  //图片item组件
  Widget _item(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(left: BorderSide(width: 0.5, color: Colors.black12))),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text(
              '￥${recommendList[index]['Price']}',
              style: TextStyle(
                  decoration: TextDecoration.lineThrough, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }

  //横向列表方法
  Widget _recommedList() {
    return Container(
        height: ScreenUtil().setHeight(330),
        // margin: EdgeInsets.only(top: 10),
        child: ListView.builder(
          //listview生成器
          scrollDirection: Axis.horizontal, //设置为横向
          itemCount: recommendList.length,
          itemBuilder: (context, index) {
            return _item(index);
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(380),
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [_titleWidget(), _recommedList()],
      ),
    );
  }
}

//TODO 楼层标题
class FloorTitle extends StatelessWidget {
  final String picture_address;
  FloorTitle({this.picture_address});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Image.network(picture_address),
    );
  }
}

//TODO 楼层商品列表
class FloorContent extends StatelessWidget {
  final List floorGoodList;
  FloorContent({this.floorGoodList});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [_firstRow(), _otherGoods()],
      ),
    );
  }

  Widget _firstRow() {
    return Row(
      children: [
        _goodItem(floorGoodList[0]),
        Column(
          children: [_goodItem(floorGoodList[1]), _goodItem(floorGoodList[2])],
        )
      ],
    );
  }

  Widget _goodItem(Map goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {
          print('dianjid');
        },
        child: Image.network(goods['image']),
      ),
    );
  }

  Widget _otherGoods() {
    return Row(
      children: [
        _goodItem(floorGoodList[3]),
        _goodItem(floorGoodList[4]),
      ],
    );
  }
}

class HotGoods extends StatefulWidget {
  @override
  _HotGoodsState createState() => _HotGoodsState();
}

class _HotGoodsState extends State<HotGoods> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    request('homePageBelowConten', formData: 1).then((value) => {print(value)});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('s'),
    );
  }
}

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   TextEditingController typeController = TextEditingController();
//   String showText = '欢迎您的到来';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('美好人间'),
//       ),
//       body:
//       SingleChildScrollView(
//         child:Container(
//           child: Column(
//             children: <Widget>[
//               TextField(
//                 controller: typeController,
//                 decoration: InputDecoration(
//                     contentPadding: EdgeInsets.all(10.0),
//                     labelText: '美女类型',
//                     helperText: '请输入你喜欢的类型'),
//                 autofocus: false,
//               ),
//               RaisedButton(
//                 onPressed: () {
//                   _choiceAction();
//                 },
//                 child: Text('选择完毕'),
//               ),
//               Text(
//                 showText,
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 1,
//               )
//             ],
//           ),
//         ),
//       )

//     );
//   }

//   void _choiceAction() {
//     print('开始选择你喜欢的类型');
//     if (typeController.text.toString() == "") {
//       showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//                 title: Text('类型不能为空'),
//               ));
//     } else {
//       getHttp(typeController.text.toString()).then((value) => {
//             setState(() {
//               showText = value['data']['name'].toString();
//             })
//           });
//     }
//   }

//   Future getHttp(String typeText) async {
//     try {
//       Response response;
//       var data = {"name": typeText};
//       response = await Dio().get(
//           "http://www.myhost.com:7300/mock/5ee72f8c240df931e03ec5a2/tipsList",
//           queryParameters: data);
//       return response.data;
//     } catch (e) {
//       return print(e);
//     }
//   }
// }

//TODO 伪造请求头
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   String showText  ='暂无数据';
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('请求远程数据'),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               RaisedButton(
//                 child: Text('请求数据'),
//                 onPressed: _jike,
//               ),
//               Text(showText)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _jike(){
//     print('开始请求');
//     getHttp().then((value) => {
//       setState((){
//         showText = value.toString();
//       })
//     });
//   }
//
//
//   Future getHttp() async {
//     try{
//       Response response ;
//       Dio dio  = new Dio();
//       dio.options.headers = httpHeader;
//       response = await dio.post('https://time.geekbang.org/serv/v1/column/labels');
//       print(2);print(response);
//       return response.data;
//     }catch(e){
//       print(1);
//       return print(e);
//     }
//   }
// }
