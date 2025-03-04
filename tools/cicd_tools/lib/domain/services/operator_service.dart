import 'package:cicd_tools/domain/entities/operator.dart';

class OperatorService {
  static final OperatorService _instance = OperatorService._();

  OperatorService._();

  factory OperatorService() => _instance;

  // 全局存放
  OperatorEntity? curr;
}
