import 'package:cicd_tools/domain/entities/operator.dart';
import 'package:cicd_tools/domain/repo/operator_repo.dart';

class OperatorRepoImpl extends OperatorRepo {
  final Map<String, OperatorEntity> _operators = {}..addEntries([
      // 录入操作员信息
      OperatorEntity(name: 'cbn', pwd: '123'),
      OperatorEntity(name: 'hsm', pwd: '123'),
    ].map((e) => MapEntry(e.name, e)).toList(growable: false));

  @override
  Future<OperatorEntity?> getOperator(
      {required String name, required String pwd}) async {
    if (_operators.containsKey(name)) {
      if (_operators[name]!.pwd == pwd) {
        return _operators[name]!;
      }
    }
    return null;
  }
}
