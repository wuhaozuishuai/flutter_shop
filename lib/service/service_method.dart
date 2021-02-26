import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

//获取首页主题内容


// Future getHomePageContent() async {
//   try{
//     print('开始获取首页主题内容');
//     Response response;
//     Dio dio = new Dio();
//     dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded").toString();
//     var formData = {'lon':'115.45454','lat':'56.15555'};
//     response = await dio.post(servicePath['homePageContent'],data: formData);
//     if (response.statusCode == 200) {
//       return response.data;
//     } else{
//       throw Exception('后端接口异常');//主动抛出异常
//     }
//   }catch(e){
//     return print('Error:=======>${e}');
//   }
// }

//TODO 获得火爆专区的商品方法
Future request(url,{formData}) async {
  try{
    print('开始获取数据');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded").toString();
   if (formData != null) {
     response = await dio.post(servicePath[url],data: formData);
   }else{
     response = await dio.post(servicePath[url]);
   }

    if (response.statusCode == 200) {
      return response.data;
    } else{
      throw Exception('后端接口异常');//主动抛出异常
    }
  }catch(e){
    return print('Error:=======>${e}');
  }
}