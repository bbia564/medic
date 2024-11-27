import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medication_record/resource/R.dart';
import 'package:medication_record/ui/settings/logic.dart';
import 'package:medication_record/utils/app_color.dart';
import 'package:medication_record/utils/routers.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final SettingsLogic logic = Get.put(SettingsLogic());

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFC9E6DA), Color(0xFFF4F4F4)])),
        child: Column(
          children: [
            _title(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                height: 175.h,
                margin: EdgeInsets.only(top: 12.w),
                padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 12.h),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.w))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GetBuilder(
                        init: logic,
                        builder: (context) {
                          return GestureDetector(
                            onTap: () {
                              logic.closeOpen();
                            },
                            child: _item(
                                title: 'Turn on notifications',
                                child: Image.asset(
                                  logic.state.isOpen.value
                                      ? R.drawable.switch_open
                                      : R.drawable.switch_close,
                                  width: 53.w,
                                )),
                          );
                        }),
                    Container(
                      color: const Color(0xFFEFEFEF),
                      height: 1.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        logic.clearAll();
                      },
                      child: _item(title: 'Clear list'),
                    ),
                    Container(
                      color: const Color(0xFFEFEFEF),
                      height: 1.h,
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.toNamed(Routers.editList);
                        },
                        child: _item(title: 'Edit medication')),
                    Container(
                      color: const Color(0xFFEFEFEF),
                      height: 1.h,
                    ),
                    _item2(title: 'About Us')
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Widget _item({@required String? title, Widget? child}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title ?? "",
          style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF242424),
              fontWeight: FontWeight.w500),
        ),
        Row(
          children: [
            child ??
                Icon(
                  Icons.arrow_forward_ios,
                  size: 13.w,
                  color: const Color(0xFFC8C8C8),
                )
          ],
        )
      ],
    );
  }

  Widget _item2({@required String? title, Widget? child}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title ?? "",
          style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF242424),
              fontWeight: FontWeight.w500),
        ),
        Text(
          '1.0.0',
          style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF242424),
              fontWeight: FontWeight.w500,
          ),
        ).paddingOnly(right: 8),
      ],
    );
  }

  Widget _title() {
    return Container(
      height: MediaQuery.of(context).padding.top + kToolbarHeight,
      alignment: Alignment.bottomCenter,
      child: Text(
        'Settings',
        style: TextStyle(
            fontSize: 16.sp,
            color: const Color(0xFF000000),
            fontWeight: FontWeight.bold),
      ).marginOnly(bottom: 6.h),
    );
  }
}
