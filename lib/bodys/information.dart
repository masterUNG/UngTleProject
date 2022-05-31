// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:ungtleproject/utility/my_constant.dart';

import 'package:ungtleproject/widgets/show_text.dart';

class Information extends StatelessWidget {
  final String nameLogin;
  const Information({
    Key? key,
    required this.nameLogin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShowText(label: 'This is Information $nameLogin', textStyle: MyConstant().h2Style(),);
  }
}
