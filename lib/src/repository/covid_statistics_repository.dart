import 'package:covid_statistics/src/model/covid_statistics.dart';
import 'package:dio/dio.dart';
import 'package:xml/xml.dart';

class CovidStatisticsRepository {
  late var _dio;

  final bookshelfXml = '''

<?xml version="1.0" encoding="UTF-8" standalone="yes"?><response><header><resultCode>00</resultCode><resultMsg>NORMAL SERVICE.</resultMsg></header><body><items><item><accExamCnt>19141481</accExamCnt><createDt>2021-12-28 09:01:15.646</createDt><deathCnt>5346</deathCnt><decideCnt>615532</decideCnt><seq>741</seq><stateDt>20211228</stateDt><stateTime>00:00</stateTime><updateDt>null</updateDt></item><item><accExamCnt>19082135</accExamCnt><createDt>2021-12-27 08:59:50.623</createDt><deathCnt>5300</deathCnt><decideCnt>611667</decideCnt><seq>740</seq><stateDt>20211227</stateDt><stateTime>00:00</stateTime><updateDt>2021-12-28 09:01:58.604</updateDt></item><item><accExamCnt>19040194</accExamCnt><createDt>2021-12-26 07:59:54.187</createDt><deathCnt>5245</deathCnt><decideCnt>607461</decideCnt><seq>739</seq><stateDt>20211226</stateDt><stateTime>00:00</stateTime><updateDt>2021-12-28 09:01:51.139</updateDt></item><item><accExamCnt>18994820</accExamCnt><createDt>2021-12-25 07:33:26.751</createDt><deathCnt>5176</deathCnt><decideCnt>602043</decideCnt><seq>738</seq><stateDt>20211225</stateDt><stateTime>00:00</stateTime><updateDt>2021-12-28 09:01:44.345</updateDt></item><item><accExamCnt>18929158</accExamCnt><createDt>2021-12-24 09:02:52.845</createDt><deathCnt>5071</deathCnt><decideCnt>596202</decideCnt><seq>737</seq><stateDt>20211224</stateDt><stateTime>00:00</stateTime><updateDt>2021-12-26 08:01:21.022</updateDt></item><item><accExamCnt>18859285</accExamCnt><createDt>2021-12-23 08:52:40.512</createDt><deathCnt>5015</deathCnt><decideCnt>589969</decideCnt><seq>736</seq><stateDt>20211223</stateDt><stateTime>00:00</stateTime><updateDt>2021-12-26 08:01:12.336</updateDt></item><item><accExamCnt>18786344</accExamCnt><createDt>2021-12-22 09:18:12.299</createDt><deathCnt>4906</deathCnt><decideCnt>583052</decideCnt><seq>735</seq><stateDt>20211222</stateDt><stateTime>00:00</stateTime><updateDt>2021-12-26 08:01:03.41</updateDt></item><item><accExamCnt>18718803</accExamCnt><createDt>2021-12-21 09:01:45.74</createDt><deathCnt>4828</deathCnt><decideCnt>575597</decideCnt><seq>734</seq><stateDt>20211221</stateDt><stateTime>00:00</stateTime><updateDt>2021-12-26 08:00:54.121</updateDt></item><item><accExamCnt>18645857</accExamCnt><createDt>2021-12-20 09:02:35.235</createDt><deathCnt>4776</deathCnt><decideCnt>570403</decideCnt><seq>733</seq><stateDt>20211220</stateDt><stateTime>00:00</stateTime><updateDt>2021-12-26 08:00:45.727</updateDt></item></items><numOfRows>10</numOfRows><pageNo>1</pageNo><totalCount>9</totalCount></body></response>''';

  CovidStatisticsRepository() {
    _dio = Dio(
      BaseOptions(baseUrl: "http://openapi.data.go.kr/", queryParameters: {
        "serviceKey":
            "bfk1G3HOTV+n1xnrb9CJpiyzXtsXVvYbUOK/JUpzreBpg92BFLPHPVdscEe3WlTgS+Bz9do7W2P1+otrVqesPw=="
      }),
    );
  }

  Future<Covid19StatisticsModel> fetch() async {
    /*var response = await _dio.get("/openapi/service/rest/Covid19/getCovid19InfStateJson");
    final document = XmlDocument.parse(response.data);*/
    final document = XmlDocument.parse(bookshelfXml);
    final results = document.findAllElements("item");

    print(results);

    if (results.isNotEmpty) {
      return Covid19StatisticsModel.fromXml(results.first);
    } else {
      return Future.value(null);
    }
  }
}
