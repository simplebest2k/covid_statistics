import 'package:covid_statistics/src/utils/data_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'canvas/arrow_clip_path.dart';
import 'components/bar_chart.dart';
import 'components/covid_stat_viewer.dart';
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

  List<Widget> _background() {
    return [
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
            child: Obx(
              () => Text(
                controller.todayData.todayDateString,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
      Positioned(
          top: headerTopZone + 50,
          right: 50,
          child: Obx(() => CovidStatViewer(
                title: "확진자",
                addedCount: controller.todayData.decideCnt ?? 0,
                upDown: controller.todayData.decideCnt == null
                    ? ArrowDirection.MIDDLE
                    : controller.calcUpDown(controller.todayData.calcDecideCnt!),
                totalCount: 187362,
                titleColor: Colors.white,
                subValueColor: Colors.white,
              )))
    ];
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
          ..._background(),
          Positioned(
            top: headerTopZone + 200,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  )),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      _todayStatistics(),
                      SizedBox(
                        height: 20,
                      ),
                      _covidTrendChart(),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _todayStatistics() {
    return Obx(() => Row(
          children: [
            Expanded(
              child: CovidStatViewer(
                title: "격리해제",
                addedCount: 1629,
                upDown: ArrowDirection.UP,
                totalCount: 187362,
                dense: true,
              ),
            ),
            Container(
              height: 60,
              child: VerticalDivider(color: Color(0xffc7c7c7)),
            ),
            Expanded(
              child: CovidStatViewer(
                title: "검사중",
                addedCount: 1629,
                upDown: ArrowDirection.DOWN,
                totalCount: 187362,
                dense: true,
              ),
            ),
            Container(
              height: 60,
              child: VerticalDivider(color: Color(0xffc7c7c7)),
            ),
            Expanded(
              child: CovidStatViewer(
                title: "사망자",
                addedCount: controller.todayData.deathCnt ?? 0,
                upDown: controller.todayData.deathCnt == null
                    ? ArrowDirection.MIDDLE
                    : controller.calcUpDown(controller.todayData.calcDeathCnt!),
                totalCount: 187362,
                dense: true,
              ),
            ),
          ],
        ));
  }

  Widget _covidTrendChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("확진자 추이", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        SizedBox(
          height: 10,
        ),
        AspectRatio(
          aspectRatio: 1.7,
          child: Obx(() => controller.weekDatas.isEmpty
              ? Container()
              : CovidBarChart(
                  covidDatas: controller.weekDatas,
                  maxY: controller.maxDecideCnt,
                )),
        ),
      ],
    );
  }
}
