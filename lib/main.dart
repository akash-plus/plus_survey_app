import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:PLUS/Routes/routes.dart';
import 'package:PLUS/Utils/cofig.dart';
import 'package:PLUS/Utils/constant_text.dart';
import 'package:PLUS/Utils/constants.dart';
import 'package:PLUS/styles/colors.dart';
import 'package:upgrader/upgrader.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Map? deepLinkData;
  Map? gcd;
  renderInitialRoute() {
    final storage = GetStorage();
    var isLoggedIn = storage.read('is_register');

    // var token = storage.read('token');
    // var name = storage.read('name');

    // if (isLoggedIn == 1) {
    //   return Routes.HOME_PAGE;
    // } else {
    //   return Routes.ONBOARD;
    // }

    if (isLoggedIn == 1) {
      return Routes.SURVEY_FORM;
    } else {
      return Routes.SURVEY_FORM;
    }
  }

  void pushClickedPayloadReceived(Map<String, dynamic> map) {
    debugPrint("pushClickedPayloadReceived called");
    setState(() async {
      var data = jsonEncode(map);
      debugPrint("on Push Click Payload = $data");
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
      home: UpgradeAlert(
        upgrader: Upgrader(
          shouldPopScope: () => false,
          canDismissDialog: false,
          showIgnore: false,
          showLater: false,
          dialogStyle: Platform.isAndroid
              ? UpgradeDialogStyle.material
              : UpgradeDialogStyle.cupertino,
        ),
        child: GetMaterialApp(
          initialRoute: renderInitialRoute(),
          title: 'Plus+',
          theme: appTheme,
          debugShowCheckedModeBanner: false,
          getPages: AppPages.pages,
        ),
      ),
    );
  }
}
