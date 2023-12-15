import 'package:common_control/common_control.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:zkeep/components/circle_navigation.dart';
import 'package:zkeep/config/config.dart';
import 'package:zkeep/controllers/auth_controller.dart';
import 'package:zkeep/controllers/data/data_controller.dart';
import 'package:zkeep/controllers/data/low_controller.dart';
import 'package:zkeep/controllers/data/view_controller.dart';
import 'package:zkeep/controllers/join_controller.dart';
import 'package:zkeep/controllers/login_controller.dart';
import 'package:zkeep/controllers/main_controller.dart';
import 'package:zkeep/controllers/mypage_controller.dart';
import 'package:zkeep/controllers/write_controller.dart';
import 'package:zkeep/screens/data/change_screen.dart';
import 'package:zkeep/screens/data/charger_screen.dart';
import 'package:zkeep/screens/data/etc_screen.dart';
import 'package:zkeep/screens/data/generator_screen.dart';
import 'package:zkeep/screens/data/high_screen.dart';
import 'package:zkeep/screens/data/list_screen.dart';
import 'package:zkeep/screens/data/load_screen.dart';
import 'package:zkeep/screens/data/low_screen.dart';
import 'package:zkeep/screens/data/sunlight_screen.dart';
import 'package:zkeep/screens/data/view_screen.dart';
import 'package:zkeep/screens/join_screen.dart';
import 'package:zkeep/screens/login_screen.dart';
import 'package:zkeep/screens/main_screen.dart';
import 'package:zkeep/screens/mypage_screen.dart';
import 'package:zkeep/screens/write_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  */

  Intl.defaultLocale = 'ko_KR';

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
      getPages: [
        GetPage(
          name: '/',
          page: () => MainScreen(),
          //middlewares: [AuthService()],
          binding: BindingsBuilder(() {
            Get.put(MainController());
          }),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: '/login',
          page: () => LoginScreen(),
          binding: BindingsBuilder(() {
            Get.put(LoginController());
          }),
        ),
        GetPage(
          name: '/join',
          page: () => JoinScreen(),
          binding: BindingsBuilder(() {
            Get.put(JoinController());
          }),
        ),
        GetPage(
          name: '/write',
          page: () => WriteScreen(),
          //middlewares: [AuthService()],
          binding: BindingsBuilder(() {
            Get.put(WriteController());
          }),
        ),
        GetPage(
          name: '/mypage',
          page: () => MypageScreen(),
          //middlewares: [AuthService()],
          binding: BindingsBuilder(() {
            Get.put(MypageController());
          }),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: '/data',
          page: () => ListScreen(),
          //middlewares: [AuthService()],
          binding: BindingsBuilder(() {
            Get.put(DataController());
          }),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: '/data/:id',
          page: () => ViewScreen(),
          //middlewares: [AuthService()],
          binding: BindingsBuilder(() {
            final c = Get.put(ViewController());

            c.id = int.parse(Get.parameters['id']!);
          }),
        ),
        GetPage(
          name: '/data/:id/low',
          page: () => LowScreen(),
          //middlewares: [AuthService()],
          binding: BindingsBuilder(() {
            final c = Get.put(LowController());

            c.id = int.parse(Get.parameters['id']!);
          }),
        ),
        GetPage(
          name: '/data/:id/high',
          page: () => HighScreen(),
          //middlewares: [AuthService()],
          binding: BindingsBuilder(() {
            final c = Get.put(ViewController());

            c.id = int.parse(Get.parameters['id']!);
          }),
        ),
        GetPage(
          name: '/data/:id/change',
          page: () => ChangeScreen(),
          //middlewares: [AuthService()],
          binding: BindingsBuilder(() {
            final c = Get.put(ViewController());

            c.id = int.parse(Get.parameters['id']!);
          }),
        ),
        GetPage(
          name: '/data/:id/load',
          page: () => LoadScreen(),
          //middlewares: [AuthService()],
          binding: BindingsBuilder(() {
            final c = Get.put(ViewController());

            c.id = int.parse(Get.parameters['id']!);
          }),
        ),
        GetPage(
          name: '/data/:id/generator',
          page: () => GeneratorScreen(),
          //middlewares: [AuthService()],
          binding: BindingsBuilder(() {
            final c = Get.put(ViewController());

            c.id = int.parse(Get.parameters['id']!);
          }),
        ),
        GetPage(
          name: '/data/:id/etc',
          page: () => EtcScreen(),
          //middlewares: [AuthService()],
          binding: BindingsBuilder(() {
            final c = Get.put(ViewController());

            c.id = int.parse(Get.parameters['id']!);
          }),
        ),
        GetPage(
          name: '/data/:id/sunlight',
          page: () => SunlightScreen(),
          //middlewares: [AuthService()],
          binding: BindingsBuilder(() {
            final c = Get.put(ViewController());

            c.id = int.parse(Get.parameters['id']!);
          }),
        ),
        GetPage(
          name: '/data/:id/charger',
          page: () => ChargerScreen(),
          //middlewares: [AuthService()],
          binding: BindingsBuilder(() {
            final c = Get.put(ViewController());

            c.id = int.parse(Get.parameters['id']!);
          }),
        ),
      ]));
}
