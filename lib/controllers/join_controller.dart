import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/config/config.dart';
import 'package:zkeep/models/company.dart';
import 'package:zkeep/models/department.dart';
import 'package:zkeep/models/signup.dart';
import 'package:common_control/common_control.dart';

class JoinController extends GetxController {
  JoinController(this.companyId, this.departmentId);

  final int companyId;
  final int departmentId;

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
  final _department = Department().obs;

  final _level = 0.obs;
  final _level1 = 0.obs;
  final _level2 = 0.obs;

  final _year = 0.obs;
  final _year1 = 0.obs;
  final _year2 = 0.obs;
  final _month = 0.obs;
  final _month1 = 0.obs;
  final _month2 = 0.obs;
  final _day = 0.obs;
  final _day1 = 0.obs;
  final _day2 = 0.obs;

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

  int get year => _year.value;
  set year(int value) => _year.value = value;
  int get year1 => _year1.value;
  set year1(int value) => _year1.value = value;
  int get year2 => _year2.value;
  set year2(int value) => _year2.value = value;

  int get month => _month.value;
  set month(int value) => _month.value = value;
  int get month1 => _month1.value;
  set month1(int value) => _month1.value = value;
  int get month2 => _month2.value;
  set month2(int value) => _month2.value = value;

  int get day => _day.value;
  set day(int value) => _day.value = value;
  int get day1 => _day1.value;
  set day1(int value) => _day1.value = value;
  int get day2 => _day2.value;
  set day2(int value) => _day2.value = value;

  String get zip => _zip.value;
  set zip(String value) => _zip.value = value;

  String get address => _address.value;
  set address(String value) => _address.value = value;

  String get addressetc => _addressetc.value;
  set addressetc(String value) => _addressetc.value = value;

  Company get company => _company.value;
  set company(Company value) => _company.value = value;

  Department get department => _department.value;
  set department(Department value) => _department.value = value;

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

  final _departments = [].obs;
  get departments => _departments;
  set departments(value) => _departments.value = value;

  final _search = ''.obs;
  String get search => _search.value;
  set search(String value) => _search.value = value;
  List<CItem> years = [CItem(id: 0, value: '')].obs;
  List<CItem> months = [CItem(id: 0, value: '')].obs;
  List<CItem> days = [CItem(id: 0, value: '')].obs;

  @override
  onInit() async {
    super.onInit();

    items = await SignupManager.companies();
    getUrl();
    getYearMonth();
  }

  getUrl() async {
    if (companyId == 0) {
      return;
    }
    await getDepartment(companyId);
    for (int i = 0; i < items.length; i++) {
      if (items[i].id == companyId) {
        company = items[i];
        break;
      }
    }

    for (int i = 0; i < departments.length; i++) {
      if (departments[i].id == departmentId) {
        department = departments[i];
        break;
      }
    }
  }

  getYearMonth() {
    for (var i = 1970; i <= DateTime.now().year; i++) {
      years.add(CItem(id: i - 1969, value: '$i'));
    }

    for (var i = 1; i <= 12; i++) {
      months.add(CItem(id: i, value: '$i월'));
    }

    for (var i = 1; i <= 31; i++) {
      days.add(CItem(id: i, value: '$i일'));
    }
  }

  // year는 years 목록의 위치(id = 연도 - 1969), month/day는 실제 값
  String makeTakingdate(int year, int month, int day) {
    if (year == 0 || month == 0 || day == 0) {
      return '';
    }

    final y = year + 1969;
    final lastDay = DateTime(y, month + 1, 0).day;
    final d = day > lastDay ? lastDay : day;

    final m = month.toString().padLeft(2, '0');
    final dd = d.toString().padLeft(2, '0');

    return '$y-$m-$dd';
  }

  getDepartment(companyid) async {
    departments = await SignupManager.departments(companyid);
  }

  // 자격증 입력 3칸 → 가입 API 의 licenses
  List<Map<String, dynamic>> makeLicenses(bool withDate) {
    final list = <Map<String, dynamic>>[];
    final rows = [
      [certificate, level, year, month, day],
      [certificate1, level1, year1, month1, day1],
      [certificate2, level2, year2, month2, day2],
    ];
    for (final r in rows) {
      if (r[0] == 0) {
        continue;
      }
      list.add({
        'licensecategory': r[0],
        'licenselevel': r[1],
        'takingdate': withDate ? makeTakingdate(r[2], r[3], r[4]) : '',
      });
    }
    return list;
  }

  Future<bool> checkDuplicate() async {
    final res = await SignupManager.check(loginid: loginid, email: email);
    if (res['loginid'] == true) {
      loginidError = '이미 등록된 아이디입니다';
      return false;
    }
    if (res['email'] == true) {
      emailError = '이미 등록된 이메일입니다';
      return false;
    }
    return true;
  }

  // 기존 점검업체에 직원으로 가입 — 업체 관리자 승인 후 로그인할 수 있다
  Future<bool> join() async {
    if (passwd != passwdtwo) {
      passwdtwoError = '비밀번호가 맞지 않습니다.';
      return false;
    }

    if (!await checkDuplicate()) {
      return false;
    }

    tel = Config.formatPhoneNumber(tel);

    final error = await SignupManager.user({
      'loginid': loginid,
      'email': email,
      'name': name,
      'passwd': passwd,
      'tel': tel,
      'zip': zip,
      'address': address,
      'addressetc': addressetc,
      'company': company.id,
      'department': department.id,
    }, makeLicenses(true));

    if (error != null) {
      emailError = error;
      return false;
    }
    return true;
  }

  // 점검업체(개인대행 포함) 가입 — 업체와 그 업체 관리자 계정을 함께 만든다
  Future<bool> joincompany() async {
    if (passwd != passwdtwo) {
      passwdtwoError = '비밀번호가 맞지 않습니다.';
      return false;
    }

    if (!await checkDuplicate()) {
      return false;
    }

    tel = Config.formatPhoneNumber(tel);
    businessnum = Config.formatCompanyNumber(businessnum);

    final error = await SignupManager.company({
      'name': name,
      'companyno': businessnum,
      'ceo': name,
      'tel': tel,
      'email': email,
      'address': address,
      'addressetc': addressetc,
    }, {
      'loginid': loginid,
      'email': email,
      'name': name,
      'passwd': passwd,
      'tel': tel,
      'zip': zip,
      'address': address,
      'addressetc': addressetc,
    }, makeLicenses(false));

    if (error != null) {
      emailError = error;
      return false;
    }
    return true;
  }
}
