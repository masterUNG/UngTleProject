// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ungtleproject/models/product_model.dart';
import 'package:ungtleproject/utility/my_constant.dart';
import 'package:ungtleproject/widgets/show_image.dart';
import 'package:ungtleproject/widgets/show_progress.dart';
import 'package:ungtleproject/widgets/show_text.dart';
import 'package:ungtleproject/widgets/show_text_button.dart';

class MyDialog {
  final BuildContext context;
  MyDialog({
    required this.context,
  });

  void detailDialog({required ProductModel productModel}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: ListTile(
          leading: const SizedBox(
            width: 80,
            height: 80,
            child: ShowImage(),
          ),
          title: ShowText(
            label: productModel.nameFood,
            textStyle: MyConstant().h2Style(),
          ),
          subtitle: ShowText(label: 'ราคา ${productModel.price} บาท'),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImage(
              imageUrl:
                  'https://www.androidthai.in.th/flutter${productModel.image}',
              placeholder: (context, string) => const ShowProgress(),
              errorWidget: (context, string, dynamic) => const ShowImage(),
            ),
            ShowText(label: productModel.detail),
          ],
        ),
        actions: [
          ShowTextButton(
              label: 'OK',
              pressFunc: () {
                Navigator.pop(context);
              })
        ],
      ),
    );
  }
}
