import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medication_record/utils/app_color.dart';
import 'package:medication_record/utils/permissionHelper.dart';

const _kHeight = 48.0;
final _picker = ImagePicker();

Future<XFile?> showImageFilePickerDialog(BuildContext context,
    {final void Function(XFile file)? callback}) {
  return showModalBottomSheet<XFile>(
    context: context,
    backgroundColor: Colors.white,
    builder: (context) => _ImagePickerDialog(callback: callback, isFile: true),
  );
}

class _ImagePickerDialog extends StatelessWidget {
  final bool? isFile;
  final void Function(XFile file)? callback;

  const _ImagePickerDialog({Key? key, this.isFile = false, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
            onTap: () => _handleOpenGallery(context),
            child: Container(
              height: 54.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.w),
                    topRight: Radius.circular(24.w)),
              ),
              // margin: EdgeInsets.symmetric(horizontal: 25.w),
              alignment: Alignment.center,
              child: Text(
                'Choose Photo',
                style: TextStyle(color: AppColor.mainColor, fontSize: 16.sp),
              ),
            )),
        Container(
          color: const Color(0xFFF1F3F6),
          height: 1.h,
          width: ScreenUtil().screenWidth,
        ),
        GestureDetector(
            onTap: () => _handleTakePhoto(context),
            child: Container(
              height: 54.h,
              color: Colors.white,
              alignment: Alignment.center,
              child: Text(
                'Take Photo',
                style: TextStyle(color: AppColor.mainColor, fontSize: 16.sp),
              ),
            )),
        Container(
          color: const Color(0xFFF2F2F2),
          height: 4.h,
          width: ScreenUtil().screenWidth,
        ),
        GestureDetector(
            onTap: () {
              _handleCancel();
            },
            child: Container(
              height: 64.h,
              color: Colors.white,
              alignment: Alignment.center,
              child: Text(
                'Cancel',
                style: TextStyle(color: AppColor.mainColor, fontSize: 16.sp),
              ),
            )),
      ],
    );
  }

  void _handleCancel() {
    Get.back();
  }

  void _handleTakePhoto(BuildContext context) async {
    bool request =
        await PermissionHelper().checkAndRequestCameraPermissions(context);
    if (request) {
      pickOneImageFile(ImageSource.camera).then((value) {
        Get.back();
      });
    }
  }

  void _handleOpenGallery(BuildContext context) async {
    bool request =
        await PermissionHelper().checkAndRequestPhotoPermissions(context);
    if (request) {
      pickOneImageFile(ImageSource.gallery).then((value) {
        Get.back();
      });
    }
  }

  pickOneImageFile(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source, maxHeight: 1024);
    if (callback != null) {
      callback!(pickedFile!);
    }
  }
}
