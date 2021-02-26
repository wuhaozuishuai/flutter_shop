//购物车页面
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/counter.dart';
class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Number(),
            MyButton()
          ],
        ),
      ),
    );
  }
}

class Number extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 200),
      child: Text('${Provider.of<Counter>(context).value}'),
    );
  }
}
class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: (){
        Provider.of<Counter>(context,listen: false).increment();
      },
      child: Text('递增'),
    );
  }
}

