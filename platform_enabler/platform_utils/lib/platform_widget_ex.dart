// 为 Widget 类添加扩展方法
import 'package:flutter/material.dart';

extension PaddingExtension on Widget {
  // 扩展方法，用于为 Widget 添加 Padding
  Widget addPadding(EdgeInsets padding) {
    return Padding(
      padding: padding,
      child: this,
    );
  }
}