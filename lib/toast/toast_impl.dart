import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_utils/platform_screenutils.dart';
import 'package:platform_utils/platform_utils.dart';

class ToastImpl implements IToast {
  CancelFunc? loading;

  @override
  void showToast({required String msg}) {
    BotToast.showText(text: msg);
  }

  @override
  void showLoading({String msg = 'loading...'}) {
    if (loading != null) {
      loading?.call();
    }
    loading = BotToast.showCustomLoading(toastBuilder: (builder) {
      return Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
            SizedBox(
              height: 8.sp,
            ),
            Text(msg),
          ],
        ),
      );
    });
  }

  @override
  void dismissLoading() {
    loading?.call();
  }
}
