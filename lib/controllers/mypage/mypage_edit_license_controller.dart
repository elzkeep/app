import 'package:common_control/common_control.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:zkeep/controllers/mypage/mypage_edit_controller.dart';
import 'package:zkeep/models/license.dart';
import 'package:zkeep/models/licensecategory.dart';
import 'package:zkeep/models/licenselevel.dart';

class MypageEditLicenseController extends GetxController {
  MypageEditLicenseController(this.index, this.license);
  final int index;
  final License license;

  final userid = LocalStorage('login.json').getItem('user')['id'];

  final _licensecategory = 0.obs;
  int get licensecategory => _licensecategory.value;
  set licensecategory(int value) => _licensecategory.value = value;

  final _licenselevel = 0.obs;
  int get licenselevel => _licenselevel.value;
  set licenselevel(int value) => _licenselevel.value = value;

  final _date = DateTime.now().obs;
  DateTime get date => _date.value;
  set date(DateTime value) => _date.value = value;

  @override
  onInit() {
    super.onInit();

    if (index != 0) {
      licensecategory = license.licensecategory.id;
      licenselevel = license.licenselevel.id;
      date = DateTime.parse(license.takingdate);
    }
  }

  Future<bool> save() async {
    if (licensecategory == 0) {
      return false;
    }

    if (licenselevel == 0) {
      return false;
    }

    if (index != 0) {
      license.licensecategory = Licensecategory(id: licensecategory);
      license.licenselevel = Licenselevel(id: licenselevel);
      license.takingdate = DateFormat('yyyy-MM-dd').format(date);

      await LicenseManager.update(license);
      final c = Get.find<MypageEditController>();
      await c.getLicense();
      return true;
    }

    final item = License()
      ..user = userid
      ..licensecategory = Licensecategory(id: licensecategory)
      ..licenselevel = Licenselevel(id: licenselevel)
      ..takingdate = DateFormat('yyyy-MM-dd').format(date);

    await LicenseManager.insert(item);
    final c = Get.find<MypageEditController>();
    await c.getLicense();
    return true;
  }

  Future<bool> delete() async {
    await LicenseManager.delete(license);
    final c = Get.find<MypageEditController>();
    await c.getLicense();
    return true;
  }
}
