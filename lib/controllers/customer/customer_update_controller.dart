import 'package:common_control/common_control.dart';
import 'package:intl/intl.dart';
import 'package:zkeep/controllers/customer/customer_detail_controller.dart';
import 'package:zkeep/models/building.dart';
import 'package:zkeep/models/company.dart';
import 'package:zkeep/models/customer.dart';

class CustomerUpdateController extends GetxController {
  CustomerUpdateController(this.id, this.index);

  TextEditingController companycompanyno = TextEditingController();
  TextEditingController companyname = TextEditingController();
  TextEditingController companyceo = TextEditingController();
  final _companyaddress = ''.obs;
  String get companyaddress => _companyaddress.value;
  set companyaddress(String value) => _companyaddress.value = value;
  TextEditingController companyaddressetc = TextEditingController();

  TextEditingController buildingname = TextEditingController();
  TextEditingController buildingcompanyno = TextEditingController();
  TextEditingController buildingceo = TextEditingController();
  // TextEditingController buildingaddress = TextEditingController();
  final _buildingaddress = ''.obs;
  String get buildingaddress => _buildingaddress.value;
  set buildingaddress(String value) => _buildingaddress.value = value;
  TextEditingController buildingaddressetc = TextEditingController();

  // TextEditingController type = TextEditingController();
  TextEditingController checkdate = TextEditingController();
  TextEditingController contractday = TextEditingController();
  TextEditingController managername = TextEditingController();
  TextEditingController managertel = TextEditingController();
  TextEditingController manageremail = TextEditingController();

  TextEditingController contractprice = TextEditingController();
  TextEditingController billingdate = TextEditingController();
  TextEditingController billingname = TextEditingController();
  TextEditingController billingtel = TextEditingController();
  TextEditingController billingemail = TextEditingController();

  final int id;
  final int index;

  final _item = Customer().obs;
  Customer get item => _item.value;
  set item(Customer value) => _item.value = value;

  final _contractstartdate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .obs;
  final _contractenddate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .obs;
  DateTime get contractstartdate => _contractstartdate.value;
  set contractstartdate(DateTime value) => _contractstartdate.value = value;
  DateTime get contractenddate => _contractenddate.value;
  set contractenddate(DateTime value) => _contractenddate.value = value;

  final _startday = false.obs;
  bool get startday => _startday.value;
  set startday(bool value) => _startday.value = value;

  @override
  onInit() async {
    super.onInit();

    await getItem();

    companycompanyno.text = item.company.companyno;
    companyname.text = item.company.name;
    companyceo.text = item.company.ceo;
    companyaddress = item.company.address;
    companyaddressetc.text = item.company.addressetc;

    buildingname.text = item.building.name;
    buildingcompanyno.text = item.building.companyno;
    buildingceo.text = item.building.ceo;
    buildingaddress = item.building.address;
    buildingaddressetc.text = item.building.addressetc;

    checkdate.text = item.checkdate.toString();
    contractday.text = item.contractday.toString();
    managername.text = item.managername;
    managertel.text = item.managertel;
    manageremail.text = item.manageremail;

    contractprice.text = item.contractprice.toString();
    contractstartdate = DateTime.parse(item.contractstartdate);
    contractenddate = DateTime.parse(item.contractenddate);
    billingdate.text = item.billingdate.toString();
    billingname.text = item.billingname;
    billingtel.text = item.billingtel;
    billingemail.text = item.billingemail;

    print(item.building.address);
    print(buildingaddress);
  }

  getItem() async {
    final res = await CustomerManager.get(id);
    item = res;
  }

  companySave() async {
    final company = item.company
      ..companyno = companycompanyno.text
      ..name = companyname.text
      ..ceo = companyceo.text
      ..address = companyaddress
      ..addressetc = companyaddressetc.text;

    await CompanyManager.update(company);

    final c = Get.find<CustomerDetailController>();
    c.company = company;

    return true;
  }

  buildingSave() async {
    final building = item.building
      ..companyno = buildingcompanyno.text
      ..name = buildingname.text
      ..ceo = buildingceo.text
      ..address = buildingaddress
      ..addressetc = buildingaddressetc.text;

    await BuildingManager.update(building);

    final c = Get.find<CustomerDetailController>();
    c.building = building;

    return true;
  }

  facilitySave() async {
    item.checkdate = int.parse(checkdate.text);
    item.contractday = int.parse(contractday.text);
    item.managername = managername.text;
    item.managertel = managertel.text;
    item.manageremail = manageremail.text;

    await CustomerManager.update(item);

    final c = Get.find<CustomerDetailController>();
    c.item = item;

    return true;
  }

  billingSave() async {
    item.contractprice = int.parse(contractprice.text);
    item.billingdate = int.parse(billingdate.text);
    item.billingname = billingname.text;
    item.billingtel = billingtel.text;
    item.billingemail = billingemail.text;
    item.contractstartdate = DateFormat('yyyy-MM-dd').format(contractstartdate);
    item.contractenddate = DateFormat('yyyy-MM-dd').format(contractenddate);

    await CustomerManager.update(item);

    final c = Get.find<CustomerDetailController>();
    c.item = item;

    return true;
  }
}
