import 'package:flutter_test/flutter_test.dart';
import 'package:xml/xml.dart';

void main() {
  final bookshelfXml = '''<response>
  <header>
  <resultCode>00</resultCode>
  <resultMsg>NORMAL SERVICE.</resultMsg>
  </header>
  <body>
  <items>
  <item>
  <accDefRate>3.239660237</accDefRate>
  <accExamCnt>268212</accExamCnt>
  <createDt>2020-03-15 00:00:00.000</createDt>
  <deathCnt>75</deathCnt>
  <decideCnt>8162</decideCnt>
  <seq>56</seq>
  <stateDt>20200315</stateDt>
  <stateTime>00:00</stateTime>
  <updateDt>2021-10-07 10:30:51.51</updateDt>
  </item>
  <item>
  <accDefRate>3.318000336</accDefRate>
  <accExamCnt>261335</accExamCnt>
  <createDt>2020-03-14 00:00:00.000</createDt>
  <deathCnt>72</deathCnt>
  <decideCnt>8086</decideCnt>
  <seq>55</seq>
  <stateDt>20200314</stateDt>
  <stateTime>00:00</stateTime>
  <updateDt>2021-10-07 10:30:51.51</updateDt>
  </item>
  <item>
  <accDefRate>3.458499309</accDefRate>
  <accExamCnt>248647</accExamCnt>
  <createDt>2020-03-13 00:00:00.000</createDt>
  <deathCnt>67</deathCnt>
  <decideCnt>7979</decideCnt>
  <seq>54</seq>
  <stateDt>20200313</stateDt>
  <stateTime>00:00</stateTime>
  <updateDt>2021-10-07 10:30:51.51</updateDt>
  </item>
  <item>
  <accDefRate>3.621744273</accDefRate>
  <accExamCnt>234998</accExamCnt>
  <createDt>2020-03-12 00:00:00.000</createDt>
  <deathCnt>66</deathCnt>
  <decideCnt>7869</decideCnt>
  <seq>53</seq>
  <stateDt>20200312</stateDt>
  <stateTime>00:00</stateTime>
  <updateDt>2021-10-07 10:30:51.51</updateDt>
  </item>
  <item>
  <accDefRate>3.804174536</accDefRate>
  <accExamCnt>222395</accExamCnt>
  <createDt>2020-03-11 00:00:00.000</createDt>
  <deathCnt>60</deathCnt>
  <decideCnt>7755</decideCnt>
  <seq>52</seq>
  <stateDt>20200311</stateDt>
  <stateTime>00:00</stateTime>
  <updateDt>2021-10-07 10:30:51.51</updateDt>
  </item>
  <item>
  <accDefRate>3.919308057</accDefRate>
  <accExamCnt>210144</accExamCnt>
  <createDt>2020-03-10 00:00:00.000</createDt>
  <deathCnt>54</deathCnt>
  <decideCnt>7513</decideCnt>
  <seq>51</seq>
  <stateDt>20200310</stateDt>
  <stateTime>00:00</stateTime>
  <updateDt>2021-10-07 10:30:51.51</updateDt>
  </item>
  </items>
  <numOfRows>10</numOfRows>
  <pageNo>1</pageNo>
  <totalCount>6</totalCount>
  </body>
  </response>''';

  test('코로나 전체 통계', () {
    final document = XmlDocument.parse(bookshelfXml);
    final items = document.findAllElements("item");

    var covid19Statics = <Covid19StatisticsModel>[];

    items.forEach((node) {
      covid19Statics.add(Covid19StatisticsModel.fromXml(node));
    });

    covid19Statics.forEach((element) {
      print("${element.stateDt} : ${element.decideCnt}");
    });
  });
}

class Covid19StatisticsModel {
  String? accDefRate;
  String? accExamCnt;
  String? createDt;
  String? deathCnt;
  String? decideCnt;
  String? seq;
  String? stateDt;
  String? stateTime;
  String? updateDt;

  Covid19StatisticsModel({this.accDefRate,
    this.accExamCnt,
    this.createDt,
    this.deathCnt,
    this.decideCnt,
    this.seq,
    this.stateDt,
    this.stateTime,
    this.updateDt,
  });

  factory Covid19StatisticsModel.fromXml(XmlElement xml) {
    return Covid19StatisticsModel(
      accDefRate: XmlUtils.searchResult(xml, "accDefRate"),
      accExamCnt: XmlUtils.searchResult(xml, "accExamCnt"),
      createDt: XmlUtils.searchResult(xml, "createDt"),
      deathCnt: XmlUtils.searchResult(xml, "deathCnt"),
      decideCnt: XmlUtils.searchResult(xml, "decideCnt"),
      seq: XmlUtils.searchResult(xml, "seq"),
      stateDt: XmlUtils.searchResult(xml, "stateDt"),
      stateTime: XmlUtils.searchResult(xml, "stateTime"),
      updateDt: XmlUtils.searchResult(xml, "updateDt"),
    );
  }
}

class XmlUtils {
  static String searchResult(XmlElement xml, String key) {
    return xml.findAllElements(key).map((e) => e.text).isEmpty
        ? ""
        : xml.findAllElements(key).map((e) => e.text).first;
  }
}
