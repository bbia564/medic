import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:medication_record/ui/logic.dart';
import 'package:medication_record/ui/state.dart';
import 'package:medication_record/utils/app_color.dart';
import 'package:medication_record/widgets/keep_alive_wrapper.dart';
import 'package:medication_record/widgets/load_image.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _logic = Get.put(MainLogic());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _logic.backApp,
      child: Obx(() {
        return Scaffold(
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _logic.state.pageController,
            children: _logic.state.tabList
                .map((e) => KeepAliveWrapper(
                      child: e.widget,
                      isKeep: e.text == 'Settings',
                    ))
                .toList(),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: const Color.fromRGBO(243, 249, 254, 1),
            selectedItemColor: AppColor.mainColor,
            unselectedItemColor: AppColor.color0306,
            currentIndex: _logic.state.currentIndex.value,
            onTap: (int index) => _logic.toPage(index),
            items: _logic.state.tabList.map((TabItemModel e) {
              return e.text.isNotEmpty
                  ? BottomNavigationBarItem(
                      icon: LoadImage(e.unSelectIcon,
                          width: 30.w, height: 30.w, fit: BoxFit.cover),
                      activeIcon: LoadImage(e.selectIcon,
                          width: 30.w, height: 30.w, fit: BoxFit.cover),
                      label: e.text,
                    )
                  : BottomNavigationBarItem(
                      icon: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColor.mainColor,
                          borderRadius: BorderRadius.circular(43.w * 0.5),
                        ),
                        width: 43.w,
                        height: 43.w,
                        child: Image.asset(
                          e.selectIcon,
                          width: 23.w,
                        ),
                      ),
                      activeIcon: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColor.mainColor,
                          borderRadius: BorderRadius.circular(43.w * 0.5),
                        ),
                        width: 43.w,
                        height: 43.w,
                        child: Image.asset(
                          e.selectIcon,
                          width: 23.w,
                        ),
                      ),
                      label: e.text,
                    );
            }).toList(),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    Get.delete<MainLogic>();
    super.dispose();
  }
}
