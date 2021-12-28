import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
        textTheme: GoogleFonts.nanumGothicTextTheme(
            Theme.of(context).textTheme
        ),
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(CovidStatisticsController());
      }),
      home: App(),
    );
  }
}


