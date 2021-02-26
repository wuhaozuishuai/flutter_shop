//会员中心页面
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/counter.dart';
class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('${Provider.of<Counter>(context).value}'),
      ),
    );
  }
}
