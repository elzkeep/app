import 'package:common_control/common_control.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:zkeep/models/report.dart';

class MainController extends InfiniteController {
  MainController()
      : super(
            reader: ReportManager.find,
            params:
                'user=$userId&checkdate=${DateFormat('yyyy-MM-dd').format(DateTime.now())}');

  static get userId => LocalStorage('login.json').getItem('user')['id'];
}
