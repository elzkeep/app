import 'package:common_control/common_control.dart';
import 'package:zkeep/controllers/customer/customer_detail_controller.dart';
import 'package:zkeep/models/building.dart';
import 'package:zkeep/models/company.dart';
import 'package:zkeep/models/customer.dart';

class CustomerUpdateController extends GetxController {
  CustomerUpdateController(this.id, this.index);

  TextEditingController companycompanyno = TextEditingController();
  TextEditingController companyname = TextEditingController();
  TextEditingController companyceo = TextEditingController();
  TextEditingController companyaddress = TextEditingController();
  TextEditingController companyaddressetc = TextEditingController();

  TextEditingController buildingname = TextEditingController();
  TextEditingController buildingcompanyno = TextEditingController();
  TextEditingController buildingceo = TextEditingController();
  TextEditingController buildingaddress = TextEditingController();
  TextEditingController buildingaddressetc = TextEditingController();

  // TextEditingController type = TextEditingController();
  TextEditingController checkdate = TextEditingController();
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

  @override
  onInit() async {
    super.onInit();

    await getItem();

    companycompanyno.text = item.buildingcompany.companyno;
    companyname.text = item.buildingcompany.name;
    companyceo.text = item.buildingcompany.ceo;
    companyaddress.text = item.buildingcompany.address;
    companyaddressetc.text = item.buildingcompany.addressetc;

    buildingname.text = item.building.name;
    buildingcompanyno.text = item.building.conpanyno;
    buildingceo.text = item.building.ceo;
    buildingaddress.text = item.building.address;
    buildingaddressetc.text = item.building.addressetc;

    checkdate.text = item.checkdate.toString();
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

    print(contractstartdate);
    print(contractenddate);
  }

  getItem() async {
    final res = await CustomerManager.get(id);
    item = res;
  }

  companySave() async {
    final company = item.buildingcompany
      ..companyno = companycompanyno.text
      ..name = companyname.text
      ..ceo = companyceo.text
      ..address = companyaddress.text
      ..addressetc = companyaddressetc.text;

    await CompanyManager.update(company);

    final c = Get.find<CustomerDetailController>();
    c.company = company;

    return true;
  }

  buildingSave() async {
    final building = item.building
      ..conpanyno = buildingcompanyno.text
      ..name = buildingname.text
      ..ceo = buildingceo.text
      ..address = buildingaddress.text
      ..addressetc = buildingaddressetc.text;

    await BuildingManager.update(building);

    final c = Get.find<CustomerDetailController>();
    c.building = building;

    return true;
  }

  facilitySave() async {
    item.checkdate = int.parse(checkdate.text);
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

    await CustomerManager.update(item);

    final c = Get.find<CustomerDetailController>();
    c.item = item;

    return true;
  }
}
