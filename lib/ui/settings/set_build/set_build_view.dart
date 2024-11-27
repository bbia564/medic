import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'set_build_logic.dart';

class SetBuildView extends GetView<PageLogic> {
  const SetBuildView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => controller.cartwright.value
              ? const CircularProgressIndicator(color: Colors.green)
              : buildError(),
        ),
      ),
    );
  }

  Widget buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              controller.psovf();
            },
            icon: const Icon(
              Icons.restart_alt,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
