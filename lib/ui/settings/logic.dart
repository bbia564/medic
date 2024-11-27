import 'package:get/get.dart';
import 'package:medication_record/api/db.dart';
import 'package:medication_record/ui/settings/state.dart';
import 'package:medication_record/widgets/toast_util.dart';

class SettingsLogic extends GetxController {
  final SetttingsState state = SetttingsState();

  void clearAll() async {
    ToastUtil().showLoading();
    await DatabaseService().clean();
    ToastUtil().dismiss();
  }

  void closeOpen() {
    state.isOpen.value = !state.isOpen.value;
    update();
  }
}
