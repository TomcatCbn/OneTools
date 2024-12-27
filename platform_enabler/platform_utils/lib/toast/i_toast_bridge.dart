late IToast toastHelper;

abstract class IToast {
  void showToast({required String msg});

  void showLoading({String msg = 'loading...'});

  void dismissLoading();
}
