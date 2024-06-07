import 'package:common_control/common_control.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:zkeep/controllers/mypage/mypage_controller.dart';
import 'package:zkeep/models/company.dart';
import 'package:zkeep/models/license.dart';
import 'package:zkeep/models/user.dart';

class MypageEditController extends GetxController {
  MypageEditController();

  final userid = LocalStorage('login.json').getItem('user')['id'];
  final userCompany = LocalStorage('login.json').getItem('user')['company'];

  final loginid = TextEditingController();
  final passwd = TextEditingController();
  final name = TextEditingController();
  final tel = TextEditingController();
  final email = TextEditingController();
  final addressetc = TextEditingController();

  final joinDate = TextEditingController();
  final careeryear = TextEditingController();
  final careermonth = TextEditingController();

  final _zip = ''.obs;
  final _address = ''.obs;

  String get zip => _zip.value;
  set zip(String value) => _zip.value = value;

  String get address => _address.value;
  set address(String value) => _address.value = value;

  final _date = DateTime.now().obs;
  DateTime get date => _date.value;
  set date(DateTime value) => _date.value = value;

  final _user = User().obs;
  User get user => _user.value;
  set user(User value) => _user.value = value;

  final _emailId = ''.obs;
  String get emailId => _emailId.value;
  set emailId(String value) => _emailId.value = value;

  // final _emailAddress = ''.obs;
  // String get emailAddress => _emailAddress.value;
  // set emailAddress(String value) => _emailAddress.value = value;

  final _emailAddress = 0.obs;
  int get emailAddress => _emailAddress.value;
  set emailAddress(int value) => _emailAddress.value = value;

  // final _addressStreet = ''.obs;
  // String get addressStreet => _addressStreet.value;
  // set addressStreet(String value) => _addressStreet.value = value;

  // final _addressetc = ''.obs;
  // String get addressetc => _addressetc.value;
  // set addressetc(String value) => _addressetc.value = value;

  final _errorLoginid = ''.obs;
  String get errorLoginid => _errorLoginid.value;
  set errorLoginid(String value) => _errorLoginid.value = value;

  final _errorPasswd = ''.obs;
  String get errorPasswd => _errorPasswd.value;
  set errorPasswd(String value) => _errorPasswd.value = value;

  final _errorName = ''.obs;
  String get errorName => _errorName.value;
  set errorName(String value) => _errorName.value = value;

  final _errorTel = ''.obs;
  String get errorTel => _errorTel.value;
  set errorTel(String value) => _errorTel.value = value;

  final _errorEmail = ''.obs;
  String get errorEmail => _errorEmail.value;
  set errorEmail(String value) => _errorEmail.value = value;

  final _errorCompany = ''.obs;
  String get errorCompany => _errorCompany.value;
  set errorCompany(String value) => _errorCompany.value = value;

  final _errorJoinDate = ''.obs;
  String get errorJoinDate => _errorJoinDate.value;
  set errorJoinDate(String value) => _errorJoinDate.value = value;

  final _errorCareer = ''.obs;
  String get errorCareer => _errorCareer.value;
  set errorCareer(String value) => _errorCareer.value = value;

  final _company = Company().obs;
  Company get company => _company.value;
  set company(Company value) => _company.value = value;

  final _items = [].obs;
  get items => _items;
  set items(value) => _items.value = value;

  final _search = ''.obs;
  String get search => _search.value;
  set search(String value) => _search.value = value;

  final _licenses = [].obs;
  get licenses => _licenses;
  set licenses(value) => _licenses.value = value;

  @override
  onInit() async {
    super.onInit();
    getUser();
    getComaony();
    getLicense();

    items = await CompanyManager.find(params: 'type=1');
  }

  getUser() async {
    final res = await UserManager.get(userid);
    user = res;
    loginid.text = user.loginid;
    passwd.text = user.passwd;
    name.text = user.name;
    tel.text = user.tel;
    email.text = user.email;
    zip = user.zip;
    address = user.address;
    addressetc.text = user.addressetc;
    careeryear.text = user.careeryear.toString();
    careermonth.text = user.careermonth.toString();
    date = DateTime.parse(user.date);
  }

  getLicense() async {
    final res = await LicenseManager.find(params: 'user=$userid');
    licenses = res;
  }

  getComaony() async {
    final res = await CompanyManager.get(userCompany);
    company = res;
  }

  save() async {
    bool flag = true;
    if (passwd == '') {
      errorPasswd = '패스워드를 입력하세요';
      flag = false;
    }

    if (name == '') {
      errorName = '이름을 입력하세요';
      flag = false;
    }

    if (tel == '') {
      errorTel = '전화번호를 입력하세요';
      flag = false;
    }

    if (email == '') {
      errorEmail = '이메일을 입력하세요';
      flag = false;
    }

    if (flag == false) {
      return false;
    }

    user.loginid = loginid.text;
    user.passwd = passwd.text;
    user.name = name.text;
    user.email = email.text;
    user.tel = tel.text;
    user.zip = zip;
    user.address = address;
    user.addressetc = addressetc.text;
    user.careeryear = int.parse(careeryear.text);
    user.careermonth = int.parse(careermonth.text);
    user.joindate = DateFormat('yyyy-MM-dd', 'ko_KR').format(date);
    user.company = company.id;

    await UserManager.update(user);
    final storage = LocalStorage('login.json');
    await storage.ready;
    await storage.setItem('user', user.toJson());
    // final c = Get.find<MypageController>();
    // await c.getLicense();
    return true;
  }
}
