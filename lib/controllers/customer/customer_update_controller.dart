import 'package:common_control/common_control.dart';
import 'package:zkeep/models/company.dart';

class CustomerUpdateController extends GetxController {
  CustomerUpdateController(this.id, this.index);

  TextEditingController companyno = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController ceo = TextEditingController();
  TextEditingController address = TextEditingController();

  TextEditingController buildingname = TextEditingController();
  TextEditingController buildingcompanyno = TextEditingController();
  TextEditingController buildingceo = TextEditingController();
  TextEditingController buildingaddress = TextEditingController();

  final int id;
  final int index;

  final _item = Company().obs;
  Company get item => _item.value;
  set item(Company value) => _item.value = value;

  @override
  onInit() async {
    print('id = $id');
    print('index = $index');
    super.onInit();
    item = await CompanyManager.get(id);

    companyno.text = item.companyno;
    name.text = item.name;
    ceo.text = item.ceo;
    address.text = item.address;

    buildingname.text = item.buildingname;
    buildingcompanyno.text = item.buildingcompanyno;
    buildingceo.text = item.buildingceo;
    buildingaddress.text = item.buildingaddress;
  }
}
