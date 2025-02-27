import 'package:platform_utils/platform_command.dart';

import 'cicd_errors.dart';

mixin Runnable {
  Future<Either<CICDError, Map<String, Object>>> run(
      Map<String, Object> args) async {
    return Either.left(CICDUnImplementError());
  }
}
