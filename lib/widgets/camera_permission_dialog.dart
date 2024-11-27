import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CameraPermissionDialog extends StatelessWidget {
  final VoidCallback? callback;
  const CameraPermissionDialog({Key? key, this.callback}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      height: 182.h,
      margin: EdgeInsets.symmetric(horizontal: 53.w),
      padding: EdgeInsets.only(top: 28.h),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(24.w))),
      child: Column(
        children: [
          Text(
            'Notice',
            textAlign: TextAlign.center,
            style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF333333)),
          ),
          Padding(
            padding: EdgeInsets.only(left: 0.w, right: 0.w, top: 16.w),
            child: Text(
              'Tea Testing Notes requires access to your photo library in order to change your avatar.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 12.sp,
                  height: 1.3.h,
                  fontWeight: FontWeight.normal,
                  color: const Color(0xFF333333)),
            ),
          ),
          const Expanded(child: SizedBox()),
          Container(
            height: 1.w,
            color: const Color(0xFFE9E9E9),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 52.h,
                      alignment: Alignment.center,
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 16.sp,
                              color: const Color(0xFF0069FB)),
                        ),
                      ),
                    )),
              ),
              Container(
                width: 1.w,
                height: 52.h,
                color: const Color(0xFFE9E9E9),
              ),
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      if (callback != null) {
                        callback!();
                      }
                      Get.back();
                    },
                    child: Container(
                      height: 52.h,
                      alignment: Alignment.center,
                      child: Center(
                        child: Text(
                          'Settings',
                          style: TextStyle(
                              fontSize: 16.sp,
                              decoration: TextDecoration.none,
                              color: const Color(0xFF0069FB),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )),
              )
            ],
          )
        ],
      ),
    ));
  }
}
