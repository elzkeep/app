import 'package:common_control/common_control.dart';
import 'package:intl/intl.dart';
import 'package:zkeep/models/report.dart';

class MainController extends InfiniteController {
  MainController()
      : super(
            reader: ReportManager.find,
            params:
                'checkdate=${DateFormat('yyyy-MM-dd').format(DateTime.now())}');
}
