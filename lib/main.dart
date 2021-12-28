import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'src/app.dart';
import 'src/controller/covid_statistics_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(CovidStatisticsController());
      }),
      home: App(),
    );
  }
}


