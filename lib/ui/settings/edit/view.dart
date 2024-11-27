import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medication_record/api/model.dart';
import 'package:medication_record/resource/R.dart';
import 'package:medication_record/ui/settings/edit/logic.dart';
import 'package:medication_record/widgets/load_image.dart';

class EditListPage extends StatefulWidget {
  @override
  State<EditListPage> createState() => _EditListPageState();
}

class _EditListPageState extends State<EditListPage> {
  final EditLogic logic = Get.put(EditLogic());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF4F7F4),
        appBar: AppBar(
          title: Text(
            'Edit medication',
            style: TextStyle(
                fontSize: 16.sp,
                color: const Color(0xFF000000),
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: 18,
              color: Color.fromARGB(255, 149, 124, 124),
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.w),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.w))),
          child: GetBuilder(
              init: logic,
              builder: (context) {
                return ListView(
                  children: logic.state.teas.map((element) {
                    return InkWell(
                        onTap: () {
                          Get.toNamed('/edit', parameters: {
                            'data': jsonEncode(element.toJson())
                          });
                        },
                        child: _item(element));
                  }).toList(),
                );
              }),
        ));
  }

  Widget _item(Tea tea) {
    return Container(
      height: 79.w,
      child: Column(
        children: [
          Expanded(
              child: Row(
            children: [
              ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(6.w)),
                      child: tea.image!.contains('assets')
                          ? LoadImage(
                              tea.image!,
                              width: 62.w,
                              height: 54.h,
                              defaultIcon: R.drawable.home_s_icon,
                              fit: BoxFit.cover,
                            )
                          : Image.memory(
                              base64Decode(tea.image!),
                              width: 62.w,
                              height: 54.h,
                              fit: BoxFit.cover,
                            ))
                  .marginOnly(right: 10.w),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tea.title ?? '',
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: const Color(0xFF0F0F0F),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    tea.title ?? '',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF0F0F0F),
                    ),
                  ),
                ],
              ).marginSymmetric(vertical: 12.h)),
              Icon(
                Icons.arrow_forward_ios_outlined,
                size: 23.w,
                color: const Color(0xFFD8D8D8),
              )
            ],
          )),
          Container(
            height: 1.w,
            color: const Color(0xFFD8D8D8),
          )
        ],
      ),
    );
  }
}
