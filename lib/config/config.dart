import 'dart:io';

import 'package:common_control/common_control.dart';

class Config {
  static const serverUrl = 'http://localhost:9303';
  //static const serverUrl = 'https://netb.co.kr:7443';

  static const primaryColor = Color.fromRGBO(237, 92, 66, 1.000);
  static const backgroundColor = Colors.black12;
  static const titleColor = Color.fromRGBO(52, 144, 178, 1.000);
  static const buttonColor = Color.fromRGBO(125, 125, 125, 1.000);

  static get titleStyle {
    return Style(
        margin: const EdgeInsets.only(top: 10),
        textStyle: const TextStyle(
            fontSize: 18, color: titleColor, fontWeight: FontWeight.bold));
  }

  static get boxtitleStyle {
    return Style(textStyle: const TextStyle(color: Colors.black));
  }

  static get moreStyle {
    return Style(textStyle: const TextStyle(color: Config.primaryColor));
  }

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
