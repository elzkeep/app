import 'dart:io';

import 'package:common_control/common_control.dart';

class Config {
  static const serverUrl = 'http://localhost:9301';
  //static const serverUrl = 'https://netb.co.kr:7443';

  static const primaryColor = Color.fromRGBO(237, 92, 66, 1.000);

  static String platform() {
    try {
      if (Platform.isAndroid) {
        return 'android';
      } else if (Platform.isIOS) {
        return 'ios';
      }
    } catch (e) {
      return 'web';
    }

    return 'web';
  }
}
