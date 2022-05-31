import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungtleproject/bodys/information.dart';
import 'package:ungtleproject/bodys/listview_product.dart';
import 'package:ungtleproject/utility/my_constant.dart';
import 'package:ungtleproject/widgets/show_image.dart';
import 'package:ungtleproject/widgets/show_menu.dart';
import 'package:ungtleproject/widgets/show_progress.dart';
import 'package:ungtleproject/widgets/show_text.dart';

class MyService extends StatefulWidget {
  const MyService({Key? key}) : super(key: key);

  @override
  State<MyService> createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  var widgets = <Widget>[];
  int indexWidget = 0;
  String? nameLogin;
  bool load = true;

  @override
  void initState() {
    super.initState();
    findDataUserLogin();
  }

  Future<void> findDataUserLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var datas = preferences.getStringList('data');
    setState(() {
      nameLogin = datas![0];
      widgets.add(const ListViewProduct());
      widgets.add(Information(nameLogin: nameLogin!));
      load = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: MyConstant.primary,),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                currentAccountPicture: const ShowImage(),
                decoration: MyConstant().basicBox(),
                accountName: ShowText(
                  label: nameLogin ?? '',
                  textStyle: MyConstant().h2Style(),
                ),
                accountEmail: null),
            ShowMenu(
                label: 'List Product',
                iconData: Icons.production_quantity_limits,
                tapFunc: () {
                  setState(() {
                    indexWidget = 0;
                  });
                  Navigator.pop(context);
                }),
            ShowMenu(
                label: 'Information',
                iconData: Icons.info_outline,
                tapFunc: () {
                  setState(() {
                    indexWidget = 1;
                  });
                  Navigator.pop(context);
                }),
            const Spacer(),
            ShowMenu(
                label: 'Sign Out',
                iconData: Icons.exit_to_app,
                tapFunc: () {
                  processSignOut(context: context);
                }),
          ],
        ),
      ),
      body: load ? const ShowProgress() : widgets[indexWidget] ,
    );
  }

  Future<void> processSignOut({required BuildContext context}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear().then((value) {
      Navigator.pushNamedAndRemoveUntil(context, '/authen', (route) => false);
    });
  }
}
