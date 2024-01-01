import 'package:common_control/common_control.dart';
import 'package:zkeep/controllers/customer/customer_list_controller.dart';
import 'package:zkeep/models/company.dart';

class InsertController extends GetxController {
  final _item = Company().obs;
  Company get item => _item.value;
  set item(Company value) => _item.value = value;

  final TextEditingController companyNo = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController ceo = TextEditingController();
  final TextEditingController address = TextEditingController();

  final _errorCompanyNo = ''.obs;
  String get errorCompanyNo => _errorCompanyNo.value;
  set errorCompanyNo(String value) => _errorCompanyNo.value = value;

  final _errorName = ''.obs;
  String get errorName => _errorName.value;
  set errorName(String value) => _errorName.value = value;

  final _errorCeo = ''.obs;
  String get errorCeo => _errorCeo.value;
  set errorCeo(String value) => _errorCeo.value = value;

  final _errorAddress = ''.obs;
  String get errorAddress => _errorAddress.value;
  set errorAddress(String value) => _errorAddress.value = value;

  Future<bool> insert() async {
    bool flag = true;
    if (companyNo.text == '') {
      errorCompanyNo = '사업자 등록번호를 입력하세요';
      flag = false;
    }

    if (name.text == '') {
      errorName = '고객명을 입력하세요';
      flag = false;
    }

    if (ceo.text == '') {
      errorCeo = '대표자명을 입력하세요';
      flag = false;
    }

    if (flag == false) {
      return false;
    }

    final item = Company()
    ..companyno = companyNo.text
    ..name = name.text
    ..ceo = ceo.text
    ..address = address.text;

    await CompanyManager.insert(item);
    final c = Get.find<CustomerListController>();
    c.reset();

    return true;
  }
}
