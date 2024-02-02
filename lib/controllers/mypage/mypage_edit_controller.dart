import 'package:common_control/common_control.dart';
import 'package:intl/intl.dart';
import 'package:zkeep/models/report.dart';

class MypageEditController extends InfiniteController {
  MypageEditController()
      : super(
            reader: ReportManager.find,
            params:
                'checkdate=${DateFormat('yyyy-MM-dd').format(DateTime.now())}');

  final loginid = TextEditingController();
  final passwd = TextEditingController();
  final name = TextEditingController();
  final phonenum = TextEditingController();
  // final adressStreet = TextEditingController();
  // final adressEtc = TextEditingController();
  final company = TextEditingController();
  final joinDate = TextEditingController();
  final career = TextEditingController();

  final _emailId = ''.obs;
  String get emailId => _emailId.value;
  set emailId(String value) => _emailId.value = value;

  // final _emailAddress = ''.obs;
  // String get emailAddress => _emailAddress.value;
  // set emailAddress(String value) => _emailAddress.value = value;

  final _emailAddress = 0.obs;
  int get emailAddress => _emailAddress.value;
  set emailAddress(int value) => _emailAddress.value = value;

  final _adressStreet = ''.obs;
  String get adressStreet => _adressStreet.value;
  set adressStreet(String value) => _adressStreet.value = value;

  final _adressEtc = ''.obs;
  String get adressEtc => _adressEtc.value;
  set adressEtc(String value) => _adressEtc.value = value;

  final _errorLoginid = ''.obs;
  String get errorLoginid => _errorLoginid.value;
  set errorLoginid(String value) => _errorLoginid.value = value;

  final _errorPasswd = ''.obs;
  String get errorPasswd => _errorPasswd.value;
  set errorPasswd(String value) => _errorPasswd.value = value;

  final _errorName = ''.obs;
  String get errorName => _errorName.value;
  set errorName(String value) => _errorName.value = value;

  final _errorPhonenum = ''.obs;
  String get errorPhonenum => _errorPhonenum.value;
  set errorPhonenum(String value) => _errorPhonenum.value = value;

  final _errorCompany = ''.obs;
  String get errorCompany => _errorCompany.value;
  set errorCompany(String value) => _errorCompany.value = value;

  final _errorJoinDate = ''.obs;
  String get errorJoinDate => _errorJoinDate.value;
  set errorJoinDate(String value) => _errorJoinDate.value = value;

  final _errorCareer = ''.obs;
  String get errorCareer => _errorCareer.value;
  set errorCareer(String value) => _errorCareer.value = value;

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
