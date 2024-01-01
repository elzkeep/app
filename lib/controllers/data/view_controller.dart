import 'package:common_control/common_control.dart';
import 'package:zkeep/controllers/data/list_controller.dart';
import 'package:zkeep/models/report.dart';

class ViewController extends GetxController {
  ViewController(this.id, this.item);

  TextEditingController content = TextEditingController();

  final int id;
  final Report item;

  final _volt = 0.obs;
  int get volt => _volt.value;
  set volt(int value) => _volt.value = value;

  @override
  onInit() {
    super.onInit();

    content.text = item.content;
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
