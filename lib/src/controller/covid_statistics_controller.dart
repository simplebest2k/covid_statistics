import 'package:covid_statistics/src/model/covid_statistics.dart';
import 'package:covid_statistics/src/repository/covid_statistics_repository.dart';
import 'package:get/get.dart';

class CovidStatisticsController extends GetxController {
  late CovidStatisticsRepository _covidStatisticsRepository;
  Rx<Covid19StatisticsModel> covidStatistics = Covid19StatisticsModel().obs;

  @override
  void onInit() {
    super.onInit();
    _covidStatisticsRepository = CovidStatisticsRepository();
    fetchCovidStatistics();
  }

  void fetchCovidStatistics() async {
    var result = await _covidStatisticsRepository.fetch();
    if (result != null) {
      covidStatistics(result);
    }
  }
}
