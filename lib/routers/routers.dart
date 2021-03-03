import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './router_handler.dart';


class Routes {
  static String root  = '/';
  static String detailsPage = '/detail';
  static void configureRoutes(FluroRouter _router){
    _router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params){
        print('Error=====>ROUTER NOT FOUND!!!');
      }
    );

    _router.define(detailsPage, handler: detailsHandler);

  }
}
