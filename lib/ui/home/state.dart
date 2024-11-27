import 'package:get/get.dart';
import 'package:medication_record/api/model.dart';

class HomeState {
  HomeState() {}

  RxMap<String, List<Tea>> teas = <String, List<Tea>>{}.obs;
}
