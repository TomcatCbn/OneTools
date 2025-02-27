// 所有的错误
sealed class CICDError {
  final String msg;

  CICDError({required this.msg});
}

class CICDUnknownError extends CICDError {
  CICDUnknownError() : super(msg: "Unknown Error");
}

class CICDUnImplementError extends CICDError {
  CICDUnImplementError() : super(msg: "UnImplement Error");
}

class CICDRuntimeError extends CICDError {
  CICDRuntimeError(String msg) : super(msg: msg);
}
