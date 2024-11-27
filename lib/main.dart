import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:medication_record/api/db.dart';
import 'package:medication_record/utils/app_router.dart';
import 'package:medication_record/utils/routers.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    DatabaseService().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      builder: (_, child) {
        return RefreshConfiguration(
          enableRefreshVibrate: true,
          enableLoadMoreVibrate: true,
          footerBuilder: () {
            return ClassicFooter(
              idleText: 'Pull up to load more',
              failedText: 'Loading failed! Click to try again!',
              canLoadingText: 'Release to load more',
              noDataText: ' ',
              loadingText: "Loading...",
              textStyle: const TextStyle(color: Color(0xFF666666)),
              loadingIcon: LoadingAnimationWidget.inkDrop(
                  color: const Color(0xFFF77159), size: 10),
            );
          },
          child: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: GetMaterialApp(
              title: '',
              debugShowCheckedModeBanner: false,
              getPages: AppRouter.pages,
              initialRoute: Routers.main,
              // navigatorObservers: [
              //   FlutterSmartDialog.observer,
              // ],
              localizationsDelegates: const [
                // 这行是关键
                RefreshLocalizations.delegate,
                // GlobalMaterialLocalizations.delegate,
                // GlobalWidgetsLocalizations.delegate
              ],
              // supportedLocales: const [Locale('zh', 'CH')],
              // locale: const Locale('zh', 'CH'),
              builder: EasyLoading.init(
                builder: (context, child) {
                  return child!;
                  // LoadingAnimationWidget.inkDrop(
                  //     color: AppColor.mainColor, size: 30.w);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
