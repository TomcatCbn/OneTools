import 'package:code_tools/screens/code_repo_batch_operate/batch_operate_state.dart';
import 'package:flutter/material.dart';

class CodeRepoSimpleItemWidget extends StatelessWidget {
  final GestureTapCallback? onClickListener;
  final CodeRepoState codeRepoState;

  const CodeRepoSimpleItemWidget(
      {required this.codeRepoState, required this.onClickListener, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClickListener,
      child: Card(
        child: Row(
          children: [
            if (codeRepoState.isSelect)
              const Icon(Icons.check_box)
            else
              const Icon(Icons.check_box_outline_blank),
            Text(codeRepoState.codeRepoName),
          ],
        ),
      ),
    );
  }
}
