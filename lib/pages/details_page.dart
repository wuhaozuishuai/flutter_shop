import 'package:flutter/material.dart';
import '';

class DetailsPage extends StatelessWidget {
  final String _goodsId;
  DetailsPage(this._goodsId);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('商品：${ _goodsId }'),
      ),
    );
  }
}
