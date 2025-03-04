import 'package:cicd_tools/domain/entities/operator.dart';

abstract class OperatorRepo {
  Future<OperatorEntity?> getOperator({
    required String name,
    required String pwd,
  });
}
