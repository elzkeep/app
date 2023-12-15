import 'package:zkeep/controllers/auth_controller.dart';
import 'package:common_control/common_control.dart';

class AuthService extends GetMiddleware {
  final c = Get.find<AuthController>();

  @override
  RouteSettings? redirect(String? route) {
    if (!c.authenticated) {
      return const RouteSettings(name: '/login');
    }

    return null;
  }
}
