import 'package:cicd_tools/domain/entities/operator.dart';
import 'package:cicd_tools/domain/repo/operator_repo.dart';
import 'package:platform_utils/platform_logger.dart';

import '../services/operator_service.dart';

class OperatorUseCase {
  OperatorEntity? get curr => OperatorService().curr;

  final OperatorRepo repo;

  OperatorUseCase({required this.repo});

  Future<bool> login(String name, String pwd) async {
    Logger.i(msg: 'OperatorUseCase login, $name');
    var operator = await repo.getOperator(name: name, pwd: pwd);
    OperatorService().curr = operator;
    Logger.i(msg: 'OperatorUseCase login ${curr != null}, $name');
    return curr != null;
  }

  void logout() {
    Logger.i(msg: 'OperatorUseCase logout');
    OperatorService().curr = null;
  }
}
