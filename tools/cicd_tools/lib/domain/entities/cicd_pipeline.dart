import 'package:cicd_tools/domain/entities/cicd_errors.dart';
import 'package:cicd_tools/domain/entities/cicd_stage.dart';
import 'package:platform_utils/log/platform_logger.dart';
import 'package:platform_utils/platform_command.dart';
import 'package:platform_utils/platform_stream_enhance.dart';

import 'cicd_action.dart';

class Pipeline with Runnable {
  // 要执行的所有stage
  final List<CICDStage> stages;
  final String pipelineName;

  Pipeline({required this.stages, required this.pipelineName});

  Stream<PipelineEvent> get pipelineEvent => _eventController.stream;

  final BehaviorSubject<PipelineEvent> _eventController = BehaviorSubject();

  @override
  Future<Either<CICDError, Map<String, Object>>> run(
      Map<String, Object> args) async {
    // 按照顺序执行所有的stage
    Logger.d(msg: '-------- begin pipeline $pipelineName---------------');
    CICDError? error;
    Map<String, Object> argsL = {};
    argsL.addAll(args);
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
}
