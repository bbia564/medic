import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:medication_record/resource/R.dart';
import 'package:medication_record/ui/home/view.dart';
import 'package:medication_record/ui/record/view.dart';
import 'package:medication_record/ui/settings/view.dart';

class TabItemModel {
  String text;
  String selectIcon;
  String unSelectIcon;
  Widget widget;

  TabItemModel({
    required this.text,
    required this.selectIcon,
    required this.widget,
    this.unSelectIcon = "",
  });
}

class MainState {
  MainState() {}

  DateTime? lastPopTime;
  PageController pageController = PageController();
  RxInt currentIndex = 0.obs;
  RxInt lastIndex = 0.obs;

  List<TabItemModel> tabList = [
    TabItemModel(
      text: "Today's",
      selectIcon: R.drawable.home_s_icon,
      unSelectIcon: R.drawable.home_u_icon,
      widget: Stack(
        children: [
          Positioned.fill(child: HomePage()),
        ],
      ),
      // widget: HistoryRecordPage(),
    ),
    TabItemModel(
      text: "Add",
      selectIcon: R.drawable.center_s_icon,
      unSelectIcon: R.drawable.center_u_icon,
      widget: Stack(
        children: [
          Positioned.fill(child: RecordPage()),
        ],
      ),
      // widget: HistoryRecordPage(),
    ),
    TabItemModel(
      text: "Settings",
      selectIcon: R.drawable.settings_s_icon,
      unSelectIcon: R.drawable.settings_u_icon,
      widget: Stack(
        children: [
          Positioned.fill(
            child: SettingsPage(),
          ),
        ],
      ),
    ),
  ];
}
