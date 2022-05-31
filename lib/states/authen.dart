import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungtleproject/models/user_model.dart';
import 'package:ungtleproject/utility/my_constant.dart';
import 'package:ungtleproject/widgets/show_button.dart';
import 'package:ungtleproject/widgets/show_form.dart';
import 'package:ungtleproject/widgets/show_image.dart';
import 'package:ungtleproject/widgets/show_text.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  bool obSecuText = true;
  String? user, password;
  bool displayError = false;
  Widget? myWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
        child: Container(
          decoration: MyConstant().basicBox(),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    newImage(),
                    newTitle(),
                    formUser(),
                    formPassword(),
                    buttonLogin(),
                  ],
                ),
              ),
              displayError ? myWidget! : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Column alertError({required String error}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShowText(
              label: error,
              textStyle: MyConstant().h3ErrorStyle(),
            ),
          ],
        ),
      ],
    );
  }

  Container buttonLogin() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: 250,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ShowButton(
            label: 'Login',
            pressFunc: () {
              print('## user = $user, password = $password');
              if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
                setState(() {
                  displayError = true;
                  myWidget = alertError(error: 'Have Space');
                });
              } else {
                setState(() {
                  displayError = false;
                });

                processCheckAuthen();
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> processCheckAuthen() async {
    String pathAPI =
        'https://www.androidthai.in.th/flutter/getUserWhereUser.php?isAdd=true&user=$user';
    await Dio().get(pathAPI).then((value) {
      if (value.toString() == 'null') {
        setState(() {
          displayError = true;
          myWidget = alertError(error: 'no $user in my Database');
        });
      } else {
        setState(() {
          displayError = false;
        });

        print('## value ==> $value');

        var result = json.decode(value.data);
        print('## result ==> $result');

        // for (var element in result) {
        //   print('## element ==> $element');

        //   UserModel userModel = UserModel.fromMap(element);
        //   if (password == userModel.password) {
        //     setState(() {
        //       displayError = false;
        //     });
        //   } else {
        //     setState(() {
        //       displayError = true;
        //       myWidget = alertError(error: 'Password False');
        //     });
        //   }
        // }

        UserModel userModel = UserModel.fromMap(result[0]);
        if (password == userModel.password) {
          processSaveSharePreferance(userModel: userModel);
        } else {
          setState(() {
            displayError = true;
            myWidget = alertError(error: 'Password False');
          });
        }
      }
    });
  }

  Future<void> processSaveSharePreferance(
      {required UserModel userModel}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var datas = <String>[];
    datas.add(userModel.name);
    datas.add(userModel.user);
    datas.add(userModel.password);
    await sharedPreferences.setStringList('data', datas).then((value) {
         Navigator.pushNamedAndRemoveUntil(
              context, '/myService', (route) => false);
          // Navigator.pushNamed(context, '/myService');
    });
  }

  ShowForm formPassword() {
    return ShowForm(
      pressFunc: () {
        setState(() {
          obSecuText = !obSecuText;
        });
      },
      label: 'Password :',
      iconData: Icons.lock_outline,
      obSecuText: obSecuText,
      changeFunc: (String password) {
        this.password = password.trim();
      },
    );
  }

  ShowForm formUser() {
    return ShowForm(
      label: 'User :',
      iconData: Icons.account_box_outlined,
      changeFunc: (String user) {
        this.user = user.trim();
      },
    );
  }

  ShowText newTitle() => ShowText(
        label: 'Login :',
        textStyle: MyConstant().h1Style(),
      );

  SizedBox newImage() {
    return const SizedBox(
      width: 150,
      child: ShowImage(),
    );
  }
}
