import 'dart:io';

import 'package:cicd_tools/domain/entities/cicd_errors.dart';
import 'package:cicd_tools/domain/entities/stages/cicd_stage.dart';
import 'package:cicd_tools/domain/entities/stage_config.dart';
import 'package:cicd_tools/plugin/cicd_tools_plugins.dart';
import 'package:platform_utils/platform_command.dart';
import 'package:platform_utils/platform_stream_enhance.dart';
import 'package:platform_utils/platform_utils.dart';

import 'cicd_action.dart';

class Pipeline with Runnable {
  // 要执行的所有stage
  final List<CICDStage> stages;
  final String pipelineName;
  int id = 0;
  final Map<String, Object> initialArgs = {};
  PipelineStatus pipelineStatus = PipelineStatus.idle;
  String operationLog = '';

  Pipeline({
    required this.stages,
    required this.pipelineName,
    Map<String, Object> args = const <String, Object>{},
    Environment? environment,
  }) {
    initialArgs.addAll(args);
    // 设置工作空间
    String workDir = '${CICDTools().workDirName}/pipelines/$pipelineName';
    initialArgs[CONFIG_PIPELINE_WORKSPACE] = workDir;
    // 添加环境变量
    if (environment != null) {
      var envMap = {
        if (environment.androidHome.isNotEmpty)
          CONFIG_ENV_ANDROID_HOME: environment.androidHome,
        if (environment.javaHome.isNotEmpty)
          CONFIG_ENV_JAVA_HOME: environment.javaHome,
      };
      initialArgs[CONFIG_PIPELINE_ENVIRONMENT] = envMap;
      Logger.i(msg: 'pipeline env = $envMap');
    }
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

    args[CONFIG_PIPELINE_BUILD_ID] = '$id.${formatDate(DateTime.now(), [
          yyyy,
          '-',
          mm,
          '-',
          dd,
          '-',
          HH,
          ':',
          nn,
          ':',
          ss
        ])}';

    pipelineStatus = PipelineStatus.running;
    _eventController.add(
        PipelineStatusChangedEvent(status: PipelineStatus.running, id: id));

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
      pipelineStatus = PipelineStatus.success;
      _eventController.add(
          PipelineStatusChangedEvent(status: PipelineStatus.success, id: id));
      return Either.right(argsL);
    }
    pipelineStatus = PipelineStatus.failed;
    _eventController
        .add(PipelineStatusChangedEvent(status: PipelineStatus.failed, id: id));
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

class PipelineStatusChangedEvent extends PipelineEvent {
  final PipelineStatus status;
  final int id;

  PipelineStatusChangedEvent({required this.status, required this.id});
}

enum PipelineType {
  aar,
  pod,
  apk,
  ipa,
  androidCheckModule,
  iosCheckModule,
}

// 为 PipelineType 枚举添加扩展
extension PipelineTypeExtension on String {
  // 扩展方法，用于将字符串转换为 PipelineType 枚举值
  PipelineType toPipelineType() {
    switch (this) {
      case 'aar':
        return PipelineType.aar;
      case 'pod':
        return PipelineType.pod;
      case 'apk':
        return PipelineType.apk;
      case 'ipa':
        return PipelineType.ipa;
      case 'androidCheckModule':
        return PipelineType.androidCheckModule;
      case 'iosCheckModule':
        return PipelineType.iosCheckModule;
      default:
        // 当传入的字符串无法匹配时，抛出异常
        throw ArgumentError('Invalid string for PipelineType: $this');
    }
  }
}

class PipelineRecord {
  int id;
  final String pipelineName;

  PipelineStatus status = PipelineStatus.idle;

  final DateTime createTime;

  DateTime? completedTime;

  final String operator;

  final String operationLog;

  // 关联的模块
  final List<String> modulesName;

  PipelineRecord({
    this.id = 0,
    required this.operator,
    required this.pipelineName,
    required this.createTime,
    required this.operationLog,
    required this.modulesName,
  });

  @override
  String toString() {
    return 'PipelineRecord{id: $id, pipelineName: $pipelineName, status: $status, createTime: ${format(createTime)}, completedTime: ${format(completedTime)}, operator: $operator}';
  }

  String format(DateTime? date) {
    if (date == null) {
      return '';
    }
    return formatDate(
        date, [yyyy, '-', mm, '-', dd, '-', HH, ':', nn, ':', ss]);
  }
}

enum PipelineStatus {
  cancelled,
  abort,
  success,
  failed,
  running,
  idle,
}

// 为 PipelineStatus 枚举添加扩展
extension PipelineStatusExtension on String {
  // 扩展方法，用于将字符串转换为 PipelineStatus 枚举值
  PipelineStatus toPipelineStatus() {
    switch (this) {
      case 'cancelled':
        return PipelineStatus.cancelled;
      case 'abort':
        return PipelineStatus.abort;
      case 'success':
        return PipelineStatus.success;
      case 'failed':
        return PipelineStatus.failed;
      case 'idle':
        return PipelineStatus.idle;
      case 'running':
        return PipelineStatus.running;
      default:
        // 当传入的字符串无法匹配时，抛出异常
        throw ArgumentError('Invalid string for PipelineStatus: $this');
    }
  }
}
