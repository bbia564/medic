import 'package:get/get.dart';
import 'package:medication_record/api/db.dart';
import 'package:medication_record/api/model.dart';
import 'package:medication_record/ui/settings/edit/state.dart';

class EditLogic extends GetxController {
  final EditState state = EditState();

  @override
  void onReady() async {
    getAll();
    super.onReady();
  }

  void getAll() async {
    List<Tea> teaList = await DatabaseService().getAll();
    state.teas.value = teaList;
    update();
  }
}
