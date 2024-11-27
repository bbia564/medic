import 'package:get/get.dart';
import 'package:medication_record/ui/settings/edit/edit/view.dart';
import 'package:medication_record/ui/settings/edit/view.dart';
import 'package:medication_record/ui/view.dart';
import 'routers.dart';

class AppRouter {
  static final List<GetPage> pages = [
    GetPage(name: Routers.main, page: () => MainPage()),
    GetPage(name: Routers.editList, page: () => EditListPage()),
    GetPage(name: Routers.edit, page: () => EditPage()),
  ];
}
