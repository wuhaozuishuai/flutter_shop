/// code : "0"
/// message : "success"
/// data : [{"image":"https://images.baixingliangfan.cn/compressedPic/20180712180233_4501.jpg","oriPrice":2.5,"presentPrice":2.5,"goodsName":"崂山啤酒8°330ml","goodsId":"86388a0ee7bd4a9dbe79f4a38c8acc89"},{"image":"https://images.baixingliangfan.cn/compressedPic/20180712181330_9746.jpg","oriPrice":2.5,"presentPrice":2.5,"goodsName":"雪花啤酒8°清爽330ml","goodsId":"87013c4315e54927a97e51d0645ece76"},{"image":"https://images.baixingliangfan.cn/compressedPic/20190116164250_1839.jpg","oriPrice":2.5,"presentPrice":2.5,"goodsName":"哈尔滨小麦王10°330ml","goodsId":"d31a5a337d43433385b17fe83ce2676a"},{"image":"https://images.baixingliangfan.cn/compressedPic/20180712180452_721.jpg","oriPrice":3.8,"presentPrice":3.8,"goodsName":"青岛啤酒11°330ml","goodsId":"a42c0585015540efa7e9642ec1183940"},{"image":"https://images.baixingliangfan.cn/compressedPic/20210127103325_9635.jpg","oriPrice":4,"presentPrice":4,"goodsName":"雪花啤酒（勇闯天涯）8°330ml","goodsId":"3e989023a30d4439bc44fb180b01101b"},{"image":"https://images.baixingliangfan.cn/compressedPic/20180717151454_4834.jpg","oriPrice":5,"presentPrice":4.5,"goodsName":"青岛啤酒8°500ml","goodsId":"fc85510c3af7428dbf1cb0c1bcb43711"},{"image":"https://images.baixingliangfan.cn/compressedPic/20180717151537_3425.jpg","oriPrice":4.6,"presentPrice":4.6,"goodsName":"百威啤酒听装9.7°330ml","goodsId":"91a849140de24546b0de9e23d85399a3"},{"image":"https://images.baixingliangfan.cn/compressedPic/20190121100327_1855.jpg","oriPrice":6.5,"presentPrice":5.5,"goodsName":"福佳4.9%白啤酒11.7°P330ml","goodsId":"3a79607209a044aeb1926c10bb837a75"},{"image":"https://images.baixingliangfan.cn/compressedPic/20210127103502_2597.jpg","oriPrice":6.5,"presentPrice":6.5,"goodsName":"科罗娜（凯罗拉）瓶装啤酒4.5°330ml","goodsId":"1e1179ea5d6549198fc221b311a27f41"},{"image":"https://images.baixingliangfan.cn/compressedPic/20210125160257_9167.jpg","oriPrice":9.5,"presentPrice":9.5,"goodsName":"1664白啤酒330ml","goodsId":"a85ba3be5c204d48b15ba34230b08708"},{"image":"https://images.baixingliangfan.cn/compressedPic/20200221112637_5222.jpg","oriPrice":15,"presentPrice":15,"goodsName":"凯斯特精酿黑啤酒11.3°P 1L","goodsId":"d72d353bb35b49eaa81ab55b0f3cd75c"},{"image":"https://images.baixingliangfan.cn/compressedPic/20200225112639_1997.jpg","oriPrice":19.5,"presentPrice":19.5,"goodsName":"锐澳鸡尾酒三连包330ml*3","goodsId":"a95961c615a84fa0be1bcdc95a8d7730"},{"image":"https://images.baixingliangfan.cn/compressedPic/20200223151040_1069.jpg","oriPrice":19.9,"presentPrice":19.9,"goodsName":"官楼四川高粱酒50°2.5L","goodsId":"10d0e9e632b640b6becc429ddf6c0842"},{"image":"https://images.baixingliangfan.cn/compressedPic/20200223151603_1060.jpg","oriPrice":21.8,"presentPrice":21.8,"goodsName":"四川官楼老白干52°2.5升","goodsId":"b3e0fe8c62fc444e81dd2cf9df7b15bb"},{"image":"https://images.baixingliangfan.cn/compressedPic/20200223151914_6972.jpg","oriPrice":25,"presentPrice":25,"goodsName":"泸州老窖头曲 52° 165ml","goodsId":"54576c6d951e476bb3603e4194ea1b3a"},{"image":"https://images.baixingliangfan.cn/compressedPic/20210125161257_3221.jpg","oriPrice":34.9,"presentPrice":34.9,"goodsName":"奥兰小红帽干红葡萄酒750ml","goodsId":"20a6dcaa00d343bca4e5d7df539be0ab"},{"image":"https://images.baixingliangfan.cn/compressedPic/20210119083421_6212.jpg","oriPrice":36,"presentPrice":36,"goodsName":"蓝亨8度特制啤酒500ml*12","goodsId":"24ba42a304564bb8bedad1b9582d66c4"},{"image":"https://images.baixingliangfan.cn/compressedPic/20210202160238_9756.jpg","oriPrice":69,"presentPrice":49,"goodsName":"德国莱纳斯黄啤5L","goodsId":"6e79960cb68e4fb3a6c01c89b11c16cf"},{"image":"https://images.baixingliangfan.cn/compressedPic/20210202160300_9752.jpg","oriPrice":69,"presentPrice":49,"goodsName":"德国莱纳斯黑啤5L","goodsId":"dfb949bf73af4918a1b1867ef8241177"},{"image":"https://images.baixingliangfan.cn/compressedPic/20200929093913_2874.jpg","oriPrice":54,"presentPrice":54,"goodsName":"英国比尔拉格黑啤酒500ml*12","goodsId":"38bc57dc017243abb5ae3c4e6168ba71"}]

class CategoryGoodsListModel {
  String _code;
  String _message;
  List<CategoryListData> _data;

  String get code => _code;

  set code(String value) {
    _code = value;
  }

  String get message => _message;
  List<CategoryListData> get data => _data;

  CategoryGoodsListModel({
      String code, 
      String message, 
      List<CategoryListData> data}){
    _code = code;
    _message = message;
    _data = data;
}

  CategoryGoodsListModel.fromJson(dynamic json) {
    _code = json["code"];
    _message = json["message"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(CategoryListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["code"] = _code;
    map["message"] = _message;
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    return map;
  }

  set message(String value) {
    _message = value;
  }

  set data(List<CategoryListData> value) {
    _data = value;
  }
}

/// image : "https://images.baixingliangfan.cn/compressedPic/20180712180233_4501.jpg"
/// oriPrice : 2.5
/// presentPrice : 2.5
/// goodsName : "崂山啤酒8°330ml"
/// goodsId : "86388a0ee7bd4a9dbe79f4a38c8acc89"

class CategoryListData {
  String _image;
  double _oriPrice;
  double _presentPrice;
  String _goodsName;
  String _goodsId;

  String get image => _image;
  double get oriPrice => _oriPrice;
  double get presentPrice => _presentPrice;
  String get goodsName => _goodsName;
  String get goodsId => _goodsId;

  CategoryListData({
      String image, 
      double oriPrice, 
      double presentPrice, 
      String goodsName, 
      String goodsId}){
    _image = image;
    _oriPrice = oriPrice;
    _presentPrice = presentPrice;
    _goodsName = goodsName;
    _goodsId = goodsId;
}

  CategoryListData.fromJson(dynamic json) {
    _image = json["image"];
    _oriPrice = json["oriPrice"];
    _presentPrice = json["presentPrice"];
    _goodsName = json["goodsName"];
    _goodsId = json["goodsId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["image"] = _image;
    map["oriPrice"] = _oriPrice;
    map["presentPrice"] = _presentPrice;
    map["goodsName"] = _goodsName;
    map["goodsId"] = _goodsId;
    return map;
  }

}