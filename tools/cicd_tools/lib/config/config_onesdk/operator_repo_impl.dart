import 'package:cicd_tools/domain/entities/operator.dart';
import 'package:cicd_tools/domain/repo/operator_repo.dart';

class OperatorRepoImpl extends OperatorRepo {
  final Map<String, OperatorEntity> _operators = {}..addEntries([
      // 录入操作员信息
      OperatorEntity(name: 'cbn', pwd: '123'),

      // developer
      // ios
      OperatorEntity(name: 'hsm', pwd: '123'),
      OperatorEntity(name: 'yjs', pwd: '123'),
      OperatorEntity(name: 'htf', pwd: '123'),
      OperatorEntity(name: 'wcy', pwd: '123'),
      OperatorEntity(name: 'czw', pwd: '123'),
      OperatorEntity(name: 'zsz', pwd: '123'),

      // android
      OperatorEntity(name: 'txj', pwd: '123'),
      OperatorEntity(name: 'fxf', pwd: '123'),
      OperatorEntity(name: 'csd', pwd: '123'),
      OperatorEntity(name: 'hg', pwd: '123'),
      OperatorEntity(name: 'wy', pwd: '123'),
      OperatorEntity(name: 'dg', pwd: '123'),
      OperatorEntity(name: 'zxy', pwd: '123'),
      OperatorEntity(name: 'jy', pwd: '123'),

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
