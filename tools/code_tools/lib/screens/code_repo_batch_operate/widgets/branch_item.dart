import 'package:flutter/cupertino.dart';

class BranchItem extends StatelessWidget {
  final String branchName;

  const BranchItem({super.key, required this.branchName});

  @override
  Widget build(BuildContext context) {
    return Text(branchName);
  }
}
