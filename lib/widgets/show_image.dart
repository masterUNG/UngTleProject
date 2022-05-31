import 'package:flutter/material.dart';


class ShowImage extends StatelessWidget {
  const ShowImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset('images/logo.png');
  }
}