import 'package:zkeep/models/login.dart';
import 'package:zkeep/models/user.dart';
import 'package:common_control/common_control.dart';
import 'package:localstorage/localstorage.dart';

class AuthController extends GetxController {
  final _authenticated = false.obs;
  final _user = User().obs;

  User get user => _user.value;
  set user(value) => _user.value = value;

  bool get authenticated => _authenticated.value;
  set authenticated(bool value) => _authenticated.value = value;

  init() async {
    super.onInit();

    final storage = LocalStorage('login.json');
    await storage.ready;
    final userItem = await storage.getItem('user');
    final token = await storage.getItem('token');

    try {
      if (userItem != null && userItem['id'] > 0) {
        authenticated = true;
        //userItem['extra'] = <String, dynamic>{};
        user = User.fromJson(userItem);

        CConfig().token = token;
      }
    } catch (e) {
      authenticated = false;
    }
  }

  login(loginid, passwd) async {
    var user = await LoginManager.login(loginid, passwd);
    if (user.id > 0) {
      CConfig().token = user.extra['token'];

      authenticated = true;
      this.user = user;

      final storage = LocalStorage('login.json');
      await storage.ready;
      await storage.setItem('user', user.toJson());
      await storage.setItem('token', CConfig().token);
    }

    return user;
  }

  logout() async {
    authenticated = false;
    user = User();

    final LocalStorage storage = LocalStorage('login.json');
    await storage.ready;
    await storage.clear();
  }
}
