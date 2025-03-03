import 'dart:io';

import 'package:cicd_tools/domain/entities/cicd_errors.dart';
import 'package:cicd_tools/domain/entities/cicd_stage.dart';
import 'package:cicd_tools/domain/entities/stage_config.dart';
import 'package:cicd_tools/plugin/cicd_tools_plugins.dart';
import 'package:flutter/foundation.dart';
import 'package:platform_utils/log/platform_logger.dart';
import 'package:platform_utils/platform_command.dart';
import 'package:platform_utils/platform_stream_enhance.dart';

import 'cicd_action.dart';

class Pipeline with Runnable {
  // 要执行的所有stage
  final List<CICDStage> stages;
  final String pipelineName;
  final Map<String, Object> initialArgs = {};

  Pipeline(
      {required this.stages,
      required this.pipelineName,
      Map<String, Object> args = const <String, Object>{}}) {
    initialArgs.addAll(args);
    // 设置工作空间
    String workDir = '${CICDTools().workDirName}/pipelines/$pipelineName';
    initialArgs[CONFIG_PIPELINE_WORKSPACE] = workDir;
    // 清理下空间
    final dir = Directory(workDir);
    if (dir.existsSync()) {
      dir.deleteSync(recursive: true);
    }
  }

  Stream<PipelineEvent> get pipelineEvent => _eventController.stream;

  final BehaviorSubject<PipelineEvent> _eventController = BehaviorSubject();

  @override
  Future<Either<CICDError, Map<String, Object>>> run(
      Map<String, Object> args) async {
    // 按照顺序执行所有的stage
    Logger.d(msg: '-------- begin pipeline $pipelineName---------------');
    CICDError? error;
    Map<String, Object> argsL = {};
    // 添加外部启动配置
    argsL.addAll(args);
    // 添加初始化的配置
    argsL.addAll(initialArgs);

    for (CICDStage stage in stages) {
      try {
        Logger.d(msg: '----------- Stage: ${stage.nameId} ---------------');
        _eventController.add(StageChangedEvent(stage: stage));
        var either = await stage.run(argsL);
        if (either.isLeft) {
          error = (either as Left<CICDError, Map<String, Object>>).value;
          break;
        }
      } catch (e) {
        Logger.e(msg: 'pipeline has error, ${stage.nameId}, $e');
        // 有报错就中断
        error = CICDRuntimeError(e.toString());
        break;
      }
    }
    Logger.d(msg: '----------- end pipeline $pipelineName ---------------');
    Logger.d(msg: '--------- ${error != null ? 'failed' : 'success'}---------');

    if (error == null) {
      return Either.right(argsL);
    }
    return Either.left(error);
  }
}

sealed class PipelineEvent {}

class StageChangedEvent extends PipelineEvent {
  final CICDStage stage;

  StageChangedEvent({required this.stage});

  @override
  String toString() {
    return 'StageChangedEvent{stage: $stage}';
  }
}
