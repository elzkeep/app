import 'package:common_control/common_control.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:zkeep/components/circle_navigation.dart';
import 'package:zkeep/config/config.dart';
import 'package:zkeep/controllers/auth_controller.dart';
import 'package:zkeep/routers/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Intl.defaultLocale = 'ko_KR';

  initializeDateFormatting();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  CConfig().serverUrl = const String.fromEnvironment('API_BASE_URL',
      defaultValue: Config.serverUrl);

  CWidget.initialize();

  Get.put(CircleNavigationController(), permanent: true);
  final c = Get.put(AuthController(), permanent: true);
  await c.init();

  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: ThemeData(fontFamily: 'Verdana'),
      locale: const Locale('ko', 'KR'),
      getPages: getPages()));
}
