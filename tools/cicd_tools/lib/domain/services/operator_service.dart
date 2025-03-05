import 'package:cicd_tools/domain/entities/operator.dart';

class OperatorService {
  static final OperatorService _instance = OperatorService._();

  OperatorService._();

  factory OperatorService() => _instance;

  // 全局存放
  OperatorEntity? curr;

  String get operatorName => curr == null ? 'unknown': curr!.name;

  // 是否skip操作员认证
  bool get skipCheck => false;
}
