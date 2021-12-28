import 'package:covid_statistics/src/canvas/arrow_clip_path.dart';
import 'package:covid_statistics/src/model/covid_statistics.dart';
import 'package:covid_statistics/src/repository/covid_statistics_repository.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CovidStatisticsController extends GetxController {
  late CovidStatisticsRepository _covidStatisticsRepository;
  Rx<Covid19StatisticsModel> _today = Covid19StatisticsModel().obs;
  RxList<Covid19StatisticsModel> _weekDatas = <Covid19StatisticsModel>[].obs;
  double maxDecideCnt = 0;

  @override
  void onInit() {
    super.onInit();
    _covidStatisticsRepository = CovidStatisticsRepository();
    fetchCovidStatistics();
  }

  void fetchCovidStatistics() async {
    var startDate = DateFormat("yyyyMMdd").format(DateTime.now().subtract(Duration(days: 8)));
    var endDate = DateFormat("yyyyMMdd").format(DateTime.now());
    var result = await _covidStatisticsRepository.fetch(startDate: startDate, endDate: endDate);

    print(result.length);

    if (result.isNotEmpty) {
      for(var i = 0; i < result.length; i++) {
        if (i < result.length - 1) {
          result[i].calcYesterday(result[i + 1]);
          if (maxDecideCnt < result[i].calcDecideCnt!) {
            maxDecideCnt = result[i].calcDecideCnt!;
          }
        }
      }

      _weekDatas.addAll(result.sublist(0, result.length - 1).reversed);
      _today(_weekDatas.last);
    }
  }

  List<Covid19StatisticsModel> get weekDatas => _weekDatas;
  Covid19StatisticsModel get todayData => _today.value;

  ArrowDirection calcUpDown(double value) {
    if (value > 0) {
      return ArrowDirection.UP;
    } else if (value < 0) {
      return ArrowDirection.DOWN;
    } else {
      return ArrowDirection.MIDDLE;
    }
  }
}
