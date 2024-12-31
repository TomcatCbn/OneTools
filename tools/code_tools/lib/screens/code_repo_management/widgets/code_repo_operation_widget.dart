import 'package:flutter/material.dart';
import 'package:platform_utils/platform_screenutils.dart';

class CodeRepoOperationsWidget extends StatelessWidget {
  final List<CodeRepoOperationItemState> items;

  const CodeRepoOperationsWidget({required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0.h, // 设置列表的高度
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // 设置为水平滚动
        itemCount: items.length, // 列表项数量
        itemBuilder: (context, index) {
          var item = items[index];
          return InkWell(
            onTap: item.onTap,
            child: Container(
              width: 80.0.h,
              // 每个列表项的宽度
              margin: EdgeInsets.symmetric(horizontal: 8.0.w),
              // 每项之间的间距
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(3.0.r),
              ),
              alignment: Alignment.center,
              child: Text(
                item.text,
                style: TextStyle(color: Colors.white, fontSize: 3.0.sp),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CodeRepoOperationItemState {
  final String text;
  final GestureTapCallback onTap;

  CodeRepoOperationItemState({required this.text, required this.onTap});
}
