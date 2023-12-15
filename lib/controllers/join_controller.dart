import 'package:zkeep/models/user.dart';
import 'package:common_control/common_control.dart';

class JoinController extends GetxController {
  final _loginid = ''.obs;
  final _name = ''.obs;
  final _passwd = ''.obs;

  final _loginidError = ''.obs;
  final _nameError = ''.obs;

  String get loginid => _loginid.value;
  set loginid(String value) => _loginid.value = value;

  String get name => _name.value;
  set name(String value) => _name.value = value;

  String get passwd => _passwd.value;
  set passwd(String value) => _passwd.value = value;

  String get loginidError => _loginidError.value;
  set loginidError(String value) => _loginidError.value = value;

  String get nameError => _nameError.value;
  set nameError(String value) => _nameError.value = value;

  Future<bool> join() async {
    if ((await UserManager.find(params: 'email=$loginid')).isNotEmpty) {
      loginidError = '이미 등록된 아이디입니다';
      return false;
    }

    if ((await UserManager.find(params: 'name=$name')).isNotEmpty) {
      nameError = '이미 등록된 닉네임입니다';
      return false;
    }

    final user = User(
        email: loginid,
        name: name,
        status: UserStatus.use,
        level: UserLevel.normal,
        passwd: passwd);
    await UserManager.insert(user);

    return true;
  }
}
