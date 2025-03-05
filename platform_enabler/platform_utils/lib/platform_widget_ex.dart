// 为 Widget 类添加扩展方法
import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  // 扩展方法，用于为 Widget 添加 Padding
  Widget addPadding(EdgeInsets padding) {
    return Padding(
      padding: padding,
      child: this,
    );
  }

  Widget onTap(void Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: this,
    );
  }
}