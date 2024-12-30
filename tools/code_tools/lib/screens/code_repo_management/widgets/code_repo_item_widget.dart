import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:platform_utils/platform_logger.dart';
import 'package:platform_utils/platform_screenutils.dart';

import '../../../domain/entities/code_repo.dart';
import '../../../utils/time_utils.dart';

/// 每个code repo对应一个，是stateful，内部自己监听code repo状态，并更新界面
class CodeRepoItemWidget extends StatefulWidget {
  final CodeRepoEntity codeRepoEntity;
  final Function? deleteCallback;

  const CodeRepoItemWidget(this.codeRepoEntity,
      {this.deleteCallback, super.key});

  @override
  State<StatefulWidget> createState() => _CodeRepoItemWidgetState();
}

class _CodeRepoItemWidgetState extends State<CodeRepoItemWidget> {
  bool selectMode = false;
  bool isSelected = false;
  bool isUpdating = false;

  StreamSubscription? _listener;

  @override
  void initState() {
    super.initState();
    // 监听code repo状态
    _listener = widget.codeRepoEntity.codeRepoStatus.stream.listen((data) {
      setState(() {
        isUpdating = (data is CodeRepoStatusUpdating);
      });
    });
    widget.codeRepoEntity.prepare().then((onValue) {
      Logger.d(msg: '${widget.codeRepoEntity}');
    });
  }

  @override
  void dispose() {
    _listener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: _withSlidable(
        Row(
          children: [
            Column(
              children: [
                Text(
                    'Repo Name: ${widget.codeRepoEntity.gitEntity.repoDirName}'),
                Text('Repo dir: ${widget.codeRepoEntity.repoDir}'),
                Text('Branch: ${widget.codeRepoEntity.gitEntity.branch}'),
              ],
            ),
            SizedBox(
              width: 16.w,
            ),
            // 当前仓库状态，是否已经完成了更新
            Text('Status: ${widget.codeRepoEntity.status.desc}'),
            SizedBox(
              width: 16.w,
            ),
            if (isUpdating) const CircularProgressIndicator(),
            // 选中
            if (selectMode)
              Checkbox(
                  value: isSelected,
                  onChanged: (v) {
                    setState(() {
                      isSelected = v ?? false;
                    });
                  }),
            SizedBox(
              width: 16.w,
            ),
            // refresh btn
            InkWell(
              child: const Icon(Icons.refresh),
              onTap: () {
                widget.codeRepoEntity.prepare(force: true);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _withSlidable(Widget child) {
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: const ValueKey(0),

      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              widget.deleteCallback?.call();
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: child,
    );
  }
}

extension _StatusName on CodeRepoStatus {
  String get desc {
    String n;
    switch (this) {
      case CodeRepoStatusUpdating(action: var a):
        n = 'Updating: $a';
        break;
      case CodeRepoStatusUpdated(updateTime: var t):
        n = 'Updated: ${formatDate(t)}';
        break;
      case CodeRepoStatusFailed(reason: var r):
        n = 'Failed: $r';
        break;
      case CodeRepoStatusIdle():
        n = 'Idle';
        break;
    }

    return n;
  }
}
