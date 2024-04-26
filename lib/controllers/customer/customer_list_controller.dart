import 'package:common_control/common_control.dart';
import 'package:localstorage/localstorage.dart';
import 'package:zkeep/models/building.dart';
import 'package:zkeep/models/customer.dart';

class CustomerListController extends InfiniteController {
  CustomerListController()
      : super(reader: CustomerManager.find, params: 'user=$userId');

  static final userId = LocalStorage('login.json').getItem('user')['id'];

  final _search = 1.obs;
  int get search => _search.value;
  set search(int value) => _search.value = value;

  final _customerTotal = 0.obs;
  get customerTotal => _customerTotal.value;
  set customerTotal(value) => _customerTotal.value = value;

  final _score = 0.0.obs;
  get score => _score.value;
  set score(value) => _score.value = value;

  @override
  onInit() async {
    super.onInit();
    await getCustomerCount();
    await getBuildingScore();
  }

  getCustomerCount() async {
    final res = await CustomerManager.find(params: 'user=$userId');

    if (res.isNotEmpty) {
      customerTotal = res.length;
    }
  }

  getBuildingScore() async {
    final res = await BuildingManager.find();

    if (res.isNotEmpty) {
      for (int i = 0; i < res.length; i++) {
        score += res[i].score;
      }
    }
  }
}
