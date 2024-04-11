import 'package:zkeep/models/user.dart';
import 'package:common_control/common_control.dart';

class JoinController extends GetxController {
  final _form = false.obs;
  final _loginid = ''.obs;
  final _name = ''.obs;
  final _passwd = ''.obs;
  final _passwdtwo = ''.obs;
  final _phonenum = ''.obs;
  final _email = ''.obs;
  final _businessnum = ''.obs;
  final _building = ''.obs;
  final _certificate = 0.obs;

  final _loginidError = ''.obs;
  final _nameError = ''.obs;
  final _passwdError = ''.obs;
  final _passwdtwoError = ''.obs;
  final _emailError = ''.obs;
  final _businessnumError = ''.obs;
  final _buildingError = ''.obs;

  bool get form => _form.value;
  set form(bool value) => _form.value = value;

  String get loginid => _loginid.value;
  set loginid(String value) => _loginid.value = value;

  String get name => _name.value;
  set name(String value) => _name.value = value;

  String get passwd => _passwd.value;
  set passwd(String value) => _passwd.value = value;

  String get passwdtwo => _passwdtwo.value;
  set passwdtwo(String value) => _passwdtwo.value = value;

  String get phonenum => _phonenum.value;
  set phonenum(String value) => _phonenum.value = value;

  String get email => _email.value;
  set email(String value) => _email.value = value;

  String get businessnum => _businessnum.value;
  set businessnum(String value) => _businessnum.value = value;

  String get building => _building.value;
  set building(String value) => _building.value = value;

  int get certificate => _certificate.value;
  set certificate(int value) => _certificate.value = value;

  String get loginidError => _loginidError.value;
  set loginidError(String value) => _loginidError.value = value;

  String get nameError => _nameError.value;
  set nameError(String value) => _nameError.value = value;

  String get passwdError => _passwdError.value;
  set passwdError(String value) => _passwdError.value = value;

  String get passwdtwoError => _passwdtwoError.value;
  set passwdtwoError(String value) => _passwdtwoError.value = value;

  String get emailError => _emailError.value;
  set emailError(String value) => _emailError.value = value;

  String get businessnumError => _businessnumError.value;
  set businessnumError(String value) => _businessnumError.value = value;

  String get buildingError => _buildingError.value;
  set buildingError(String value) => _buildingError.value = value;

  Future<bool> join() async {
    if ((await UserManager.find(params: 'email=$loginid')).isNotEmpty) {
      loginidError = '이미 등록된 아이디입니다';
      return false;
    }

    // if ((await UserManager.find(params: 'name=$name')).isNotEmpty) {
    //   nameError = '이미 등록된 닉네임입니다';
    //   return false;
    // }

    if (passwd != passwdtwo) {
      passwdtwoError = '비밀번호가 맞지 않습니다.';
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
