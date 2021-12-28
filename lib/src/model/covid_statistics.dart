import 'package:covid_statistics/src/utils/data_utils.dart';
import 'package:covid_statistics/utils/xml_utils.dart';
import 'package:flutter/material.dart';
import 'package:xml/xml.dart';

class Covid19StatisticsModel {
  double? accDefRate;
  double? accExamCnt;
  String? createDt;
  double? deathCnt;
  double? calcDeathCnt = 0;
  double? decideCnt;
  double? calcDecideCnt = 0;
  String? seq;
  DateTime? stateDt;
  String? stateTime;
  String? updateDt;

  Covid19StatisticsModel({
    this.accDefRate,
    this.accExamCnt,
    this.createDt,
    this.deathCnt,
    this.decideCnt,
    this.seq,
    this.stateDt,
    this.stateTime,
    this.updateDt,
  });

  factory Covid19StatisticsModel.empty() {
    return Covid19StatisticsModel();
  }

  factory Covid19StatisticsModel.fromXml(XmlElement xml) {
    return Covid19StatisticsModel(
      accDefRate: XmlUtils.searchResultDouble(xml, "accDefRate"),
      accExamCnt: XmlUtils.searchResultDouble(xml, "accExamCnt"),
      createDt: XmlUtils.searchResultString(xml, "createDt"),
      deathCnt: XmlUtils.searchResultDouble(xml, "deathCnt"),
      decideCnt: XmlUtils.searchResultDouble(xml, "decideCnt"),
      seq: XmlUtils.searchResultString(xml, "seq"),
      stateDt: XmlUtils.searchResultString(xml, "stateDt") != null
          ? DateTime.parse(XmlUtils.searchResultString(xml, "stateDt"))
          : null,
      stateTime: XmlUtils.searchResultString(xml, "stateTime"),
      updateDt: XmlUtils.searchResultString(xml, "updateDt"),
    );
  }

  void calcYesterday(Covid19StatisticsModel yesterdayData) {
    calcDecideCnt = decideCnt! - yesterdayData.decideCnt!;
    calcDeathCnt = deathCnt! - yesterdayData.deathCnt!;
  }

  String get todayDateString =>
      stateDt == null ? "" : "${DataUtils.simpleDateFormat(stateDt!)} $stateTime 기준";
}
