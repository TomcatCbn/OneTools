// 应用聚合根

import 'module.dart';

class ApplicationAggregate {
  final String applicationId;
  Map<String, ModuleEntity> modules = {};

  ApplicationAggregate(this.applicationId);
}