import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medication_record/api/model.dart';
import 'package:medication_record/resource/R.dart';
import 'package:medication_record/ui/home/logic.dart';
import 'package:medication_record/utils/app_color.dart';
import 'package:medication_record/widgets/load_image.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeLogic _logic = Get.put(HomeLogic());

  @override
  void initState() {
    _logic.getAll();
    super.initState();
  }

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
          Expanded(
              child: GetBuilder(
                  init: _logic,
                  builder: (context) {
                    return _logic.state.teas.isNotEmpty
                        ? _listView()
                        : Center(
                            child: Image.asset(
                              R.drawable.center_u_icon,
                              width: 54.w,
                            ),
                          );
                  }))
        ],
      ),
    );
  }

  Widget _title() {
    return Container(
      height: MediaQuery.of(context).padding.top + kToolbarHeight,
      alignment: Alignment.bottomCenter,
      child: Text(
        '''Today's medication''',
        style: TextStyle(
            fontSize: 16.sp,
            color: const Color(0xFF000000),
            fontWeight: FontWeight.bold),
      ).marginOnly(bottom: 6.h),
    );
  }

  Widget _listView() {
    return Obx(() {
      List<Widget> childs = [];
      if (_logic.state.teas.isNotEmpty) {
        _logic.state.teas.forEach((key, value) {
          childs.add(_listItem(key, value));
        });
      }
      return ListView(
        children: childs,
      );
    });
  }

  Widget _listItem(String key, List<Tea> value) {
    List<Widget> childs = [
      Text(
        key,
        style: TextStyle(
            fontSize: 16.sp,
            color: const Color(0xFF242424),
            fontWeight: FontWeight.bold),
      ).marginOnly(left: 12.w).marginOnly(left: 5.w, bottom: 8.w)
    ];
    if (value.isNotEmpty) {
      for (var element in value) {
        childs.add(GestureDetector(onTap: () {}, child: _item(element)));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: childs,
    ).marginOnly(left: 16.w, right: 16.w, bottom: 16.w);
  }

  Widget _item(Tea tea) {
    return Card(
        borderOnForeground: false,
        shadowColor: const Color(0xFF000000).withOpacity(0.16),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0.w),
        ),
        child: Container(
            height: 122.h,
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(6.w))),
            child: Row(
              children: [
                ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(6.w)),
                        child: tea.image!.contains('assets')
                            ? LoadImage(
                                tea.image!,
                                width: 95.w,
                                height: 95.h,
                                defaultIcon: R.drawable.home_s_icon,
                                fit: BoxFit.cover,
                              )
                            : Image.memory(
                                base64Decode(tea.image!),
                                width: 95.w,
                                height: 95.h,
                                fit: BoxFit.cover,
                              ))
                    .marginOnly(right: 12.w),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          tea.title ?? '',
                          style: TextStyle(
                              fontSize: 16.sp, color: const Color(0xFF242424)),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 13.w,
                          color: const Color(0xFFC4C4C4),
                        )
                      ],
                    ),
                    Container(
                      height: 1.h,
                      color: const Color(0xFFEFEFEF),
                    ),
                    Text(
                      tea.experience ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12.sp, color: const Color(0xFFB2B2B2)),
                    ),
                    Text(
                      tea.evaluation ?? '',
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColor.mainColor),
                    ),
                  ],
                ))
              ],
            )));
  }
}
