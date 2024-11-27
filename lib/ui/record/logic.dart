import 'dart:convert';
import 'dart:io';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medication_record/api/db.dart';
import 'package:medication_record/api/model.dart';
import 'package:medication_record/ui/logic.dart';
import 'package:medication_record/ui/record/state.dart';
import 'package:medication_record/widgets/image_picker_dialog.dart';
import 'package:medication_record/widgets/toast_util.dart';

class RecordLogic extends GetxController {
  final RecordState state = RecordState();

  @override
  void onReady() async {
    super.onReady();
  }

  void choseAvator(BuildContext context) async {
    // await showImageFilePickerDialog(
    //   context,
    //   callback: (file) {
    //     if (file != null) {
    //       state.imageFile.value = file;
    //       update();
    //     }
    //   },
    // );
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(
          imageQuality: 90,
          maxWidth: 1024,
          source: ImageSource.gallery
      );
      if (pickedFile != null) {
        state.imageFile.value = pickedFile;
        update();
      }
    } catch (e) {
      return;
    }
  }

  void checkTypes(ItemModel model) {
    for (var i = 0; i < state.types.length; i++) {
      state.types[i].isSelected = false;
      if (state.types[i].text == model.text) {
        state.types[i].isSelected = true;
        if (state.types[i].text == 'Capsule') {
          state.type.value = 'particle';
        }
        if (state.types[i].text == 'Medicine tablet') {
          state.type.value = 'Piece';
        }
        if (state.types[i].text == 'Liquid') {
          state.type.value = 'ml';
        }
        if (state.types[i].text == 'External use') {
          state.type.value = 'g';
        }
      }
    }
    update();
  }

  Future<String> imageToBase64(File image) async {
    List<int> imageBytes = await image.readAsBytes();
    return base64Encode(imageBytes);
  }

  void checkTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context, firstDate: DateTime(2020), lastDate: DateTime(2030));
    if (picked != null) {
      state.cuTime.value = '${picked.year}/${picked.month}/${picked.day}';
    }
    update();
  }

  void clearTime() {
    state.cuTime.value = '';
    update();
  }

  void submit() async {
    if (state.nameTF.text.isEmpty) {
      ToastUtil().showToast('Please enter the name.');
      return;
    }

    if (state.imageFile.value.path.isEmpty) {
      ToastUtil().showToast('Please select a picture.');
      return;
    }

    if (state.type.isEmpty) {
      ToastUtil().showToast('Please select the type of medication.');
      return;
    }

    if (state.valueTF.text.isEmpty) {
      ToastUtil().showToast('Please enter the dosage.');
      return;
    }

    if (state.cuTime.isEmpty) {
      ToastUtil().showToast('Please select a time.');
      return;
    }

    ToastUtil().showLoading();
    String image = await imageToBase64(File(state.imageFile.value.path));
    DatabaseService().insert(Tea(
        id: faker.randomGenerator.integer(100, min: 21),
        title: state.nameTF.text,
        evaluation: state.valueTF.text,
        image: image,
        experience: state.type.value,
        time: state.cuTime.value));

    ToastUtil().dismiss();

    state.nameTF.text = '';
    state.imageFile = XFile('').obs;
    state.type = 'particle'.obs;
    state.valueTF.text = '';
    state.cuTime = ''.obs;
    MainLogic lo = Get.find<MainLogic>();
    lo.toPage(0);
  }
}
