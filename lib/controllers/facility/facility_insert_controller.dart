import 'package:common_control/common_control.dart';
import 'package:zkeep/models/company.dart';

class FacilityInsertController extends GetxController {
  FacilityInsertController(this.id);

  final int id;

  final _item = Company().obs;
  Company get item => _item.value;
  set item(Company value) => _item.value = value;

  final _type = 0.obs;
  int get type => _type.value;
  set type(int value) => _type.value = value;

  final _position = 0.obs;
  int get position => _position.value;
  set position(int value) => _position.value = value;

  final _arrangement = 0.obs;
  int get arrangement => _arrangement.value;
  set arrangement(int value) => _arrangement.value = value;

  final _arrangementtype = 0.obs;
  int get arrangementtype => _arrangementtype.value;
  set arrangementtype(int value) => _arrangementtype.value = value;

  final _arrangementface = 0.obs;
  int get arrangementface => _arrangementface.value;
  set arrangementface(int value) => _arrangementface.value = value;

  final _distributation = 0.obs;
  int get distributation => _distributation.value;
  set distributation(int value) => _distributation.value = value;

  final _distributationtype = 0.obs;
  int get distributationtype => _distributationtype.value;
  set distributationtype(int value) => _distributationtype.value = value;

  final _distributationface = 0.obs;
  int get distributationface => _distributationface.value;
  set distributationface(int value) => _distributationface.value = value;

  final _years = 0.obs;
  int get years => _years.value;
  set years(int value) => _years.value = value;

  @override
  onInit() async {
    super.onInit();
    item = await CompanyManager.get(id);
  }
}
