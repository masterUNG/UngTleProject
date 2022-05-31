// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:ungtleproject/utility/my_constant.dart';

class ShowText extends StatelessWidget {
  final String label;
  final TextStyle? textStyle;
  const ShowText({
    Key? key,
    required this.label,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(label, style: textStyle ?? MyConstant().h3Style(),);
  }
}
