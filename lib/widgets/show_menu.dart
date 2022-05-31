// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:ungtleproject/utility/my_constant.dart';
import 'package:ungtleproject/widgets/show_text.dart';

class ShowMenu extends StatelessWidget {
  final String label;
  final IconData iconData;
  final Function() tapFunc;
  const ShowMenu({
    Key? key,
    required this.label,
    required this.iconData,
    required this.tapFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconData, color: MyConstant.dart, size: 36,),
      title: ShowText(label: label, textStyle: MyConstant().h2Style(),),
      onTap: tapFunc,
    );
  }
}
