import 'dart:convert';
import 'dart:io';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medication_record/api/db.dart';
import 'package:medication_record/api/model.dart';
import 'package:medication_record/ui/logic.dart';
import 'package:medication_record/ui/settings/edit/edit/state.dart';
import 'package:medication_record/utils/routers.dart';
import 'package:medication_record/widgets/image_picker_dialog.dart';
import 'package:medication_record/widgets/toast_util.dart';
import 'package:path_provider/path_provider.dart';

class EditingLogic extends GetxController {
  final EditingState state = EditingState();

  @override
  void onReady() async {
    var result = Get.parameters;
    if (result != null && result['data'] != null) {
      Tea tea = Tea.fromJson(jsonDecode(result['data'].toString()));
      state.nameTF.text = tea.title ?? '';

      final bytes = base64Decode(tea.image ?? '');
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/image.png';
      final file = File(path);
      await file.writeAsBytes(bytes);
      state.imageFile.value = XFile(file.path);
      state.type.value = tea.experience ?? '';
      if (state.type.value == 'Piece') {
        for (var i = 0; i < state.types.length; i++) {
          state.types[i].isSelected = false;
        }
        state.types[1].isSelected = true;
      } else if (state.type.value == 'ml') {
        for (var i = 0; i < state.types.length; i++) {
          state.types[i].isSelected = false;
        }
        state.types[2].isSelected = true;
      } else if (state.type.value == 'g') {
        for (var i = 0; i < state.types.length; i++) {
          state.types[i].isSelected = false;
        }
        state.types[3].isSelected = true;
      } else {
        state.types[0].isSelected = true;
      }

      state.valueTF.text = tea.evaluation ?? '';
      state.cuTime.value = tea.time ?? '';
      state.id.value = tea.id ?? 0;

      update();
    }
    super.onReady();
  }

  void choseAvator(BuildContext context) async {
    await showImageFilePickerDialog(
      context,
      callback: (file) {
        if (file != null) {
          state.imageFile.value = file;
          update();
        }
      },
    );
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
    DatabaseService().update(Tea(
        id: state.id.value,
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
    Get.until((route) => Get.currentRoute == Routers.main);
    MainLogic lo = Get.find<MainLogic>();
    lo.toPage(0);
  }
}
