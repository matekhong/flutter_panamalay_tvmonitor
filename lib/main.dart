import 'dart:io';

import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter_panamaly_tvmonitor/controller/projectpartprogress_controller.dart';
import 'package:flutter_panamaly_tvmonitor/widgets/ProjectProgressTable.dart';
import 'package:get/get.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
  Get.put<ProjectPartProgressController>(ProjectPartProgressController());
  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(600, 450);
    win.minSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "Custom window with Flutter";
    win.show();
  });
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

const borderColor = Color(0xFF805306);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: WindowBorder(
          color: borderColor,
          width: 1,
          child: Row(
            children: const [ProjectProgressTable()],
          ),
        ),
      ),
    );
  }
}
