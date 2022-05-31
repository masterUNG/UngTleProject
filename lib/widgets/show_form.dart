// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:ungtleproject/utility/my_constant.dart';
import 'package:ungtleproject/widgets/show_text.dart';

class ShowForm extends StatelessWidget {
  final String label;
  final IconData iconData;
  final bool? obSecuText;
  final Function()? pressFunc;
  final Function(String) changeFunc;
  const ShowForm({
    Key? key,
    required this.label,
    required this.iconData,
    this.obSecuText,
    this.pressFunc,
    required this.changeFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: 250,
      height: 40,
      child: TextFormField(onChanged: changeFunc,
        obscureText: obSecuText ?? false,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
          fillColor: Colors.white.withOpacity(0.35),
          filled: true,
          suffixIcon: pressFunc == null
              ? const SizedBox()
              : IconButton(
                  onPressed: pressFunc,
                  icon: Icon(
                    Icons.remove_red_eye_outlined,
                    color: MyConstant.primary,
                  ),
                ),
          prefixIcon: Icon(
            iconData,
            color: MyConstant.dart,
          ),
          label: ShowText(label: label),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: MyConstant.dart),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: MyConstant.primary),
          ),
        ),
      ),
    );
  }
}
