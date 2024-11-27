import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medication_record/resource/R.dart';
import 'package:medication_record/ui/record/logic.dart';
import 'package:medication_record/ui/record/state.dart';
import 'package:medication_record/utils/app_color.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';

class RecordPage extends StatefulWidget {
  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  final RecordLogic logic = Get.put(RecordLogic());

  @override
  void initState() {
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
        children: [_title(), Expanded(child: _content())],
      ),
    );
  }

  Widget _content() {
    return GetBuilder(
        init: logic,
        builder: (tcontext) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.w))),
            child: ListView(
              children: [
                _name(
                  'Drug name',
                ),
                Container(
                  height: 50.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.w)),
                      border: Border.all(
                          width: 1.w, color: const Color(0xFFD1D1D1))),
                  child: CupertinoTextField(
                    textInputAction: TextInputAction.done,
                    controller: logic.state.nameTF,
                    padding: const EdgeInsets.all(0),
                    keyboardType: TextInputType.text,
                    decoration: null,
                    placeholder: 'Enter name',
                    placeholderStyle: TextStyle(
                      color: const Color(0xFFB2B2B2),
                      fontSize: 12.sp,
                    ),
                    style: TextStyle(
                      color: const Color(0xFF242424),
                      fontSize: 12.sp,
                    ),
                    onChanged: (value) {},
                    onSubmitted: (value) {},
                  ),
                ).marginOnly(top: 10.w),
                _name(
                  'Drug picture',
                ).marginOnly(top: 14.w),
                GestureDetector(
                  onTap: () {
                    logic.choseAvator(context);
                  },
                  child: Row(
                    children: [
                      logic.state.imageFile.value != null &&
                              logic.state.imageFile.value.path.isNotEmpty
                          ? ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.w)),
                              child: Image.file(
                                File(logic.state.imageFile.value.path),
                                width: 107.w,
                                height: 107.w,
                                fit: BoxFit.cover,
                              ),
                            ).marginOnly(top: 14.w)
                          : Container(
                              width: 107.w,
                              height: 107.w,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFF7F7F7),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.w))),
                              child: Center(
                                child: Image.asset(
                                  R.drawable.add_s_icon,
                                  width: 35.w,
                                ),
                              ),
                            ).marginOnly(top: 14.w),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                ),
                _name('Type of medication').marginOnly(top: 10.w),
                Column(
                  children: logic.state.types.map((element) {
                    return GestureDetector(
                        onTap: () {
                          logic.checkTypes(element);
                        },
                        child: _medicaItem(element).marginOnly(top: 8.w));
                  }).toList(),
                ).marginOnly(top: 12.w),
                _name('Usage Amount').marginOnly(top: 20.w),
                Container(
                  height: 50.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.w)),
                      border: Border.all(
                        width: 1.w,
                        color: const Color(0xFFD1D1D1),
                      )),
                  child: Row(
                    children: [
                      Expanded(
                        child: CupertinoTextField(
                          textInputAction: TextInputAction.done,
                          controller: logic.state.valueTF,
                          padding: const EdgeInsets.all(0),
                          keyboardType: TextInputType.number,
                          decoration: null,
                          placeholder: 'Enter Usage Amount',
                          placeholderStyle: TextStyle(
                            color: const Color(0xFFB2B2B2),
                            fontSize: 12.sp,
                          ),
                          style: TextStyle(
                            color: const Color(0xFF242424),
                            fontSize: 12.sp,
                          ),
                          onChanged: (value) {},
                          onSubmitted: (value) {},
                        ),
                      ),
                      Text(
                        logic.state.type.value,
                        style: TextStyle(
                            fontSize: 13.sp, color: const Color(0xFF505050)),
                      ).marginOnly(left: 12.w)
                    ],
                  ),
                ).marginOnly(top: 10.w),
                _name('Medication time').marginOnly(top: 20.w),
                logic.state.cuTime.value.isEmpty
                    ? GestureDetector(
                        onTap: () {
                          logic.checkTime(context);
                        },
                        child: Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            border: RDottedLineBorder.all(
                              width: 1.w,
                              dottedLength: 3.w,
                              dottedSpace: 5.w,
                              color: const Color(0xFFD1D1D1),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Click to add time',
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xFF505050)),
                            ),
                          ),
                        ).marginOnly(top: 14.w),
                      )
                    : GestureDetector(
                        onTap: () {
                          logic.checkTime(context);
                        },
                        child: Container(
                          height: 50.h,
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.w, color: const Color(0xFFD1D1D1)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.w))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 13.w,
                              ),
                              Text(
                                logic.state.cuTime.value,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: const Color(0xFF1F1F1F),
                                    fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    logic.clearTime();
                                  },
                                  child: Image.asset(
                                    R.drawable.delete_icon,
                                    width: 13.w,
                                  ))
                            ],
                          ),
                        ).marginOnly(top: 14.w),
                      ),
                GestureDetector(
                  onTap: () {
                    logic.submit();
                  },
                  child: Container(
                    height: 50.h,
                    decoration: BoxDecoration(
                        color: AppColor.mainColor,
                        borderRadius: BorderRadius.all(Radius.circular(10.w))),
                    child: Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ).marginOnly(top: 20.w),
                )
              ],
            ),
          );
        });
  }

  Widget _medicaItem(ItemModel model) {
    return Row(
      children: [
        Image.asset(
          model.isSelected! ? R.drawable.check_s_icon : R.drawable.check_u_icon,
          width: 14.w,
        ),
        Text(
          model.text ?? '',
          style: TextStyle(fontSize: 14.sp, color: AppColor.mainColor),
        ).marginOnly(left: 4.w)
      ],
    );
  }

  Widget _name(String title) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 14.sp,
          color: const Color(0xFF0F0F0F),
          fontWeight: FontWeight.bold),
    );
  }

  Widget _title() {
    return Container(
      height: MediaQuery.of(context).padding.top + kToolbarHeight,
      alignment: Alignment.bottomCenter,
      child: Text(
        'Add medication',
        style: TextStyle(
            fontSize: 16.sp,
            color: const Color(0xFF000000),
            fontWeight: FontWeight.bold),
      ).marginOnly(bottom: 6.h),
    );
  }
}
