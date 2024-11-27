import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ItemModel {
  String? text;
  bool? isSelected;

  ItemModel({
    this.text,
    this.isSelected,
  });
}

class EditingState {
  EditingState() {}

  TextEditingController nameTF = TextEditingController();
  TextEditingController valueTF = TextEditingController();
  var imageFile = XFile('').obs;
  // Rx<DateTime> cuTime = DateTime.now().obs;
  RxString cuTime = ''.obs;
  RxString type = 'particle'.obs;
  RxString value = '0'.obs;
  RxInt id = 0.obs;

  RxList<ItemModel> types = <ItemModel>[
    ItemModel(text: 'Capsule', isSelected: true),
    ItemModel(text: 'Medicine tablet', isSelected: false),
    ItemModel(text: 'Liquid', isSelected: false),
    ItemModel(text: 'External use', isSelected: false),
  ].obs;
}
