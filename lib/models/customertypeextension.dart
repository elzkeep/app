import 'package:zkeep/models/customer.dart';

extension CustomerTypeExtension on CustomerType {
  String get name {
    switch (this) {
      case CustomerType.none:
        return '';
      case CustomerType.direct:
        return '직영';
      case CustomerType.outsourcing:
        return '위탁';
      default:
        return '';
    }
  }
}
