import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:medication_record/ui/state.dart';
import 'package:medication_record/widgets/toast_util.dart';

class MainLogic extends GetxController {
  final MainState state = MainState();

  void toPage(int index) {
    state.lastIndex.value = state.currentIndex.value;
    state.currentIndex.value = index;
    state.pageController.jumpToPage(index);
  }

  ///双击退出
  Future<bool> backApp() async {
    if (state.lastPopTime == null ||
        DateTime.now().difference(state.lastPopTime!) >
            const Duration(seconds: 1000)) {
      state.lastPopTime = DateTime.now();
      ToastUtil().showToast('Click again to exit the application.');
      return Future.value(false);
    } else {
      state.lastPopTime = DateTime.now(); // 退出app
      // exit(0);
      // return Future.value(false);
      return Future.value(true);
    }
  }
}
