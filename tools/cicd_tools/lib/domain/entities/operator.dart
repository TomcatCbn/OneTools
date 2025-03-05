class OperatorEntity {
  /// 唯一标识
  final String name;

  ///
  final String pwd;

  ///
  OperatorEntity({required this.name, required this.pwd});

  @override
  String toString() {
    return 'Operator($name)';
  }
}
