import 'package:zkeep/controllers/auth_controller.dart';
import 'package:common_control/common_control.dart';

class LoginController extends GetxController {
  final _loginid = ''.obs;
  final _passwd = ''.obs;
  final _message = ''.obs;

  String get loginid => _loginid.value;
  set loginid(String value) => _loginid.value = value;

  String get passwd => _passwd.value;
  set passwd(String value) => _passwd.value = value;

  String get message => _message.value;
  set message(String value) => _message.value = value;

  login() async {
    var c = Get.find<AuthController>();

    var user = await c.login(loginid, passwd);

    if (user.id > 0) {
      return true;
    }

    message = '로그인 정보가 정확하지 않습니다';

    return false;
  }
}
