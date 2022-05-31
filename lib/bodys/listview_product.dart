import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ungtleproject/models/product_model.dart';
import 'package:ungtleproject/utility/my_constant.dart';
import 'package:ungtleproject/utility/my_dialog.dart';
import 'package:ungtleproject/widgets/show_image.dart';
import 'package:ungtleproject/widgets/show_progress.dart';
import 'package:ungtleproject/widgets/show_text.dart';

class ListViewProduct extends StatefulWidget {
  const ListViewProduct({Key? key}) : super(key: key);

  @override
  State<ListViewProduct> createState() => _ListViewProductState();
}

class _ListViewProductState extends State<ListViewProduct> {
  String pathAPI = 'https://www.androidthai.in.th/flutter/getAllFood.php';
  var productModels = <ProductModel>[];

  @override
  void initState() {
    super.initState();
    readAllData();
  }

  Future<void> readAllData() async {
    await Dio().get(pathAPI).then((value) {
      for (var element in json.decode(value.data)) {
        productModels.add(ProductModel.fromMap(element));
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return productModels.isEmpty
        ? const ShowProgress()
        : ListView.builder(
            itemCount: productModels.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  print('You Tap index ==> $index');
                  MyDialog(context: context)
                      .detailDialog(productModel: productModels[index]);
                },
                child: Card(
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            width: 150,
                            height: 120,
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://www.androidthai.in.th/flutter${productModels[index].image}',
                              fit: BoxFit.cover,
                              placeholder:
                                  (BuildContext context, String string) =>
                                      const ShowProgress(),
                              errorWidget: (BuildContext context, String string,
                                      dynamic) =>
                                  const ShowImage(),
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ShowText(
                                  label: productModels[index].nameFood,
                                  textStyle: MyConstant().h2Style(),
                                ),
                                ShowText(
                                  label: productModels[index].price,
                                  textStyle: MyConstant().h1Style(),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
