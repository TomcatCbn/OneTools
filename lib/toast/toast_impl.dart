import 'package:bot_toast/bot_toast.dart';
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
    loading = BotToast.showLoading();
  }

  @override
  void dismissLoading() {
    loading?.call();
  }
}
