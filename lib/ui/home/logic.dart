import 'package:get/get.dart';
import 'package:medication_record/api/db.dart';
import 'package:medication_record/api/model.dart';
import 'package:medication_record/ui/home/state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();

  @override
  void onReady() async {
    getAll();
    super.onReady();
  }

  void getAll() async {
    List<Tea> teas = await DatabaseService().getAll();
    state.teas.value = {};
    if (teas != null && teas.isNotEmpty) {
      for (var element in teas) {
        if (state.teas[element.time] == null) {
          state.teas[element.time!] = [element];
        } else {
          state.teas[element.time!]!.add(element);
        }
      }
    }
    update();
  }
}
