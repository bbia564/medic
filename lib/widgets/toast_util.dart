import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:medication_record/utils/app_color.dart';
import 'ding.dart';

class ToastUtil {
  factory ToastUtil() => _getInstance();

  static ToastUtil? _instance;

  bool _loadingShow = false;

  // late FToast fToast;

  ToastUtil._() {
    configLoading();
  }

  void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 5.0
      ..progressColor = Colors.white
      ..backgroundColor = Colors.transparent
      ..indicatorColor = Colors.white
      ..boxShadow = [
        const BoxShadow(
          color: Colors.transparent,
        )
      ]
      ..textColor = Colors.white
      ..textStyle = const TextStyle(fontSize: 12, color: Colors.white)
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = false
      ..dismissOnTap = false;
  }

  static ToastUtil _getInstance() {
    _instance ??= ToastUtil._();
    return _instance!;
  }

  void showToast(String msg) {
    EasyLoading.instance.backgroundColor = const Color(0xb3000000);
    EasyLoading.instance.userInteractions = true;
    EasyLoading.showToast(msg, toastPosition: EasyLoadingToastPosition.center);
  }

  void showLoading({String? tip = ''}) {
    if (_loadingShow) return;
    _loadingShow = true;
    EasyLoading.instance.backgroundColor = Colors.transparent;
    EasyLoading.instance.userInteractions = false;
    EasyLoading.show(
      status: '',
      indicator: MySpinKitFadingCircle(
        color: AppColor.mainColor,
        //size: 25.0,
        tip: tip,
      ),
      maskType: EasyLoadingMaskType.black,
    );
  }

  void dismiss() {
    _loadingShow = false;
    EasyLoading.dismiss();
  }
}
