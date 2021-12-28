import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'canvas/arrow_clip_path.dart';
import 'controller/covid_statistics_controller.dart';

class App extends GetView<CovidStatisticsController> {
  App({Key? key}) : super(key: key);

  late double headerTopZone;

  Widget infoWidget(String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Text(
            " : $value",
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    headerTopZone = Get.mediaQuery.padding.top + AppBar().preferredSize.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Icon(Icons.menu, color: Colors.white),
        elevation: 0,
        title: Text("코로나 일별 현황", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Icon(Icons.notifications, color: Colors.white),
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [Color(0xff3c727c), Color(0xff33656e)])),
          ),
          Positioned(
            left: -110,
            top: headerTopZone + 40,
            child: Container(
              child: Image.asset(
                "assets/coronavirus.png",
                width: Get.size.width * 0.7,
              ),
            ),
          ),
          Positioned(
            top: headerTopZone + 10,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xff195f68),
                ),
                child: Text(
                  "07.24 00:00 기준",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Positioned(
              top: headerTopZone + 50,
              right: 50,
              child: Column(
                children: [
                  Text(
                    "확진자",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      ClipPath(
                        clipper: ArrowClipPath(),
                        child: Container(
                          width: 20,
                          height: 20,
                          color: Color(0xffcf5f51),
                        ),
                      ),
                      SizedBox(width: 5,),
                      Text(
                        "1,629",
                        style: TextStyle(
                            color: Color(0xffcf5f51),
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text("187,362", style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),),
                ],
              ))
        ],
      ),
    );
  }
}
