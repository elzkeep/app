import 'package:common_control/common_control.dart';
import 'package:zkeep/controllers/data/list_controller.dart';
import 'package:zkeep/models/building.dart';
import 'package:zkeep/models/report.dart';

class ViewController extends GetxController {
  ViewController(this.id, this.item);

  TextEditingController content = TextEditingController();

  final int id;
  final Report item;

  final _building = Building().obs;
  Building get building => _building.value;
  set building(Building value) => _building.value = value;

  final _volt = 0.obs;
  int get volt => _volt.value;
  set volt(int value) => _volt.value = value;

  @override
  onInit() {
    super.onInit();

    content.text = item.content;
    getBuilding();
  }

  getBuilding() async {
    final res = await BuildingManager.get(item.building.id);
    building = res;
  }

  save() async {
    item.status = ReportStatus.complete;
    item.content = content.text;

    print(item.content);
    print(item.id);
    await ReportManager.update(item);

    final c = Get.find<ListController>();
    c.reset();
  }
}
