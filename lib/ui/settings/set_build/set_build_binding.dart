import 'package:get/get.dart';

import 'set_build_logic.dart';

class SetBuildBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      PageLogic(),
      permanent: true,
    );
  }
}
