import 'package:common_control/common_control.dart';
import 'package:localstorage/localstorage.dart';
import 'package:zkeep/models/company.dart';
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
  final address = TextEditingController();
  final addressetc = TextEditingController();
  final companyTextEdit = TextEditingController();
  final joinDate = TextEditingController();
  final career = TextEditingController();

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

  // final _addressEtc = ''.obs;
  // String get addressEtc => _addressEtc.value;
  // set addressEtc(String value) => _addressEtc.value = value;

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

  @override
  onInit() async {
    super.onInit();
    getUser();
    getComaony();
  }

  getUser() async {
    final res = await UserManager.get(userid);
    user = res;
    loginid.text = user.loginid;
    passwd.text = user.passwd;
    name.text = user.name;
    tel.text = user.tel;
    email.text = user.email;
    address.text = user.address;
    addressetc.text = user.addressetc;
  }

  getComaony() async {
    final res = await CompanyManager.get(userCompany);
    company = res;
    companyTextEdit.text = res.name;
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
    await UserManager.update(user);
    return true;
  }

  Future<bool> insert() async {
    // bool flag = true;

    // if (customerid == 0) {
    //   errorCompany = '점검대상을 선택하세요';
    //   flag = false;
    // }

    // if (name.text == '') {
    //   errorTitle = '점검지명을 입력하세요';
    //   flag = false;
    // }

    // if (flag == false) {
    //   return false;
    // }

    // final item = Report()
    //   ..title = name.text
    //   ..period = period
    //   ..number = ordinal
    //   ..checkdate = DateFormat('yyyy-MM-dd', 'ko_KR').format(date)
    //   ..checktime =
    //       '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}'
    //   ..company = Company(id: customerid)
    //   ..status = ReportStatus.newer;

    // await ReportManager.insert(item);

    return true;
  }
}
