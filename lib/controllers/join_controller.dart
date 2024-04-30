import 'package:zkeep/config/config.dart';
import 'package:zkeep/models/company.dart';
import 'package:zkeep/models/license.dart';
import 'package:zkeep/models/licensecategory.dart';
import 'package:zkeep/models/licenselevel.dart';
import 'package:zkeep/models/user.dart';
import 'package:common_control/common_control.dart';

class JoinController extends GetxController {
  final _form = false.obs;
  final _loginid = ''.obs;
  final _name = ''.obs;
  final _passwd = ''.obs;
  final _passwdtwo = ''.obs;
  final _tel = ''.obs;
  final _email = ''.obs;
  final _businessnum = ''.obs;
  final _building = ''.obs;
  final _certificate = 0.obs;
  final _certificate1 = 0.obs;
  final _certificate2 = 0.obs;
  final _zip = ''.obs;
  final _address = ''.obs;
  final _addressetc = ''.obs;
  final _company = Company().obs;

  final _level = 0.obs;
  final _level1 = 0.obs;
  final _level2 = 0.obs;

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

  String get tel => _tel.value;
  set tel(String value) => _tel.value = value;

  String get email => _email.value;
  set email(String value) => _email.value = value;

  String get businessnum => _businessnum.value;
  set businessnum(String value) => _businessnum.value = value;

  String get building => _building.value;
  set building(String value) => _building.value = value;

  int get certificate => _certificate.value;
  set certificate(int value) => _certificate.value = value;
  int get certificate1 => _certificate1.value;
  set certificate1(int value) => _certificate1.value = value;
  int get certificate2 => _certificate2.value;
  set certificate2(int value) => _certificate2.value = value;

  int get level => _level.value;
  set level(int value) => _level.value = value;
  int get level1 => _level1.value;
  set level1(int value) => _level1.value = value;
  int get level2 => _level2.value;
  set level2(int value) => _level2.value = value;

  String get zip => _zip.value;
  set zip(String value) => _zip.value = value;

  String get address => _address.value;
  set address(String value) => _address.value = value;

  String get addressetc => _addressetc.value;
  set addressetc(String value) => _addressetc.value = value;

  Company get company => _company.value;
  set company(Company value) => _company.value = value;

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

  final _items = [].obs;
  get items => _items;
  set items(value) => _items.value = value;

  final _search = ''.obs;
  String get search => _search.value;
  set search(String value) => _search.value = value;

  @override
  onInit() async {
    super.onInit();

    items = await CompanyManager.find();
  }

  Future<bool> join() async {
    print(email);
    if ((await UserManager.find(params: 'email=$email')).isNotEmpty) {
      emailError = '이미 등록된 아이디입니다';
      return false;
    }

    if (passwd != passwdtwo) {
      passwdtwoError = '비밀번호가 맞지 않습니다.';
      return false;
    }

    tel = Config.formatPhoneNumber(tel);

    final user = User(
        loginid: name,
        email: email,
        name: name,
        status: UserStatus.use,
        level: UserLevel.normal,
        approval: UserApproval.wait,
        passwd: passwd,
        tel: tel,
        zip: zip,
        address: address,
        addressetc: addressetc,
        company: company.id);
    final res = await UserManager.insert(user);

    if (certificate != 0) {
      final license = License(
        user: res,
        licensecategory: Licensecategory(id: certificate),
        licenselevel: Licenselevel(id: level),
      );
      await LicenseManager.insert(license);
    }

    if (certificate1 != 0) {
      final license1 = License(
        user: res,
        licensecategory: Licensecategory(id: certificate1),
        licenselevel: Licenselevel(id: level1),
      );
      await LicenseManager.insert(license1);
    }

    if (certificate2 != 0) {
      final license2 = License(
        user: res,
        licensecategory: Licensecategory(id: certificate2),
        licenselevel: Licenselevel(id: level2),
      );
      await LicenseManager.insert(license2);
    }
    return true;
  }

  Future<bool> joincompany() async {
    if ((await UserManager.find(params: 'email=$email')).isNotEmpty) {
      emailError = '이미 등록된 아이디입니다';
      return false;
    }

    if (passwd != passwdtwo) {
      passwdtwoError = '비밀번호가 맞지 않습니다.';
      return false;
    }

    tel = Config.formatPhoneNumber(tel);
    businessnum = Config.formatCompanyNumber(businessnum);

    final company = Company(
      name: name,
      companyno: businessnum,
      ceo: name,
      tel: tel,
      email: email,
      address: address,
      addressetc: addressetc,
      type: CompanyType.work,
    );

    final res = await CompanyManager.insert(company);

    final user = User(
        loginid: name,
        email: email,
        name: name,
        status: UserStatus.use,
        level: UserLevel.normal,
        approval: UserApproval.complete,
        passwd: passwd,
        tel: tel,
        zip: zip,
        address: address,
        addressetc: addressetc,
        company: res);
    await UserManager.insert(user);

    return true;
  }
}
