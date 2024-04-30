import 'dart:ui';

import 'package:common_control/common_control.dart';
import 'package:zkeep/models/report.dart';

extension ReportStatusExtension on ReportStatus {
  Color get color {
    switch (this) {
      case ReportStatus.none:
        return Colors.grey;
      case ReportStatus.newer:
        return const Color.fromRGBO(48, 168, 255, 100);
      // return const Color.fromRGBO(0, 133, 255, 100);
      case ReportStatus.ing:
        return const Color.fromRGBO(123, 123, 123, 100);
      case ReportStatus.check:
        return const Color.fromRGBO(219, 126, 59, 100);
      case ReportStatus.complete:
        return const Color.fromRGBO(246, 126, 39, 100);
      // return const Color.fromRGBO(237, 92, 67, 100);
      default:
        return Colors.grey;
    }
  }

  String get name {
    switch (this) {
      case ReportStatus.none:
        return '없음';
      case ReportStatus.newer:
        return '신규';
      case ReportStatus.ing:
        return '점검중';
      case ReportStatus.check:
        return '작성완료';
      case ReportStatus.complete:
        return '점검완료';
      default:
        return '';
    }
  }
}
