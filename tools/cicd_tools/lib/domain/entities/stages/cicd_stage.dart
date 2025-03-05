// CICD Stage抽象
import 'dart:io';

import 'package:cicd_tools/domain/entities/gradle_action.dart';
import 'package:cicd_tools/domain/entities/stage_config.dart';
import 'package:platform_utils/platform_command.dart';
import 'package:platform_utils/platform_utils.dart';

import '../cicd_errors.dart';
import '../module.dart';

abstract class CICDStage {
  final String nameId;

  int progress = 0;

  CICDStage({required this.nameId});

  Future<Either<CICDError, Map<String, Object>>> run(Map<String, Object> args);

  @override
  String toString() {
    return 'CICDStage{nameId: $nameId}';
  }
}

// TODO
/// 本地单测
class UnitStage extends CICDStage {
  UnitStage({required super.nameId});

  @override
  Future<Either<CICDError, Map<String, Object>>> run(Map<String, Object> args) {
    // TODO: implement run
    throw UnimplementedError();
  }
}

// TODO
/// sonar上传
class SonarStage extends CICDStage {
  SonarStage({required super.nameId});

  @override
  Future<Either<CICDError, Map<String, Object>>> run(Map<String, Object> args) {
    // TODO: implement run
    throw UnimplementedError();
  }
}







