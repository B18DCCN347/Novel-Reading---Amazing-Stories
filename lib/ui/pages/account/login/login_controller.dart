import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:love_novel/app/global/controller.dart';
import 'package:love_novel/app/utils/dialogs.dart';
import 'package:love_novel/data/repositories/auth.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.isRegistered<LoginController>()
      ? Get.find()
      : Get.put(LoginController());
  final _appController = AppController.instance;

  String userName = "";
  String password = "";

  Future<void> loginAsAnonymous() async {
    // if (userName.isEmpty && password.isEmpty) {
    //   Dialogs.alert(message: "Vui lòng nhập đầy đủ thông tin.");
    //   return;
    // }
    // if (_appController.connectivityResult.value == ConnectivityResult.mobile ||
    //     _appController.connectivityResult.value == ConnectivityResult.wifi) {
    //   Dialogs.showProgress(message: "Đang đăng nhập...");
    //   var isLoggedIn = await AuthRepository()
    //       .loginAsAnonymous(userName, password)
    //       .catchError((error) {});
    //   Dialogs.hideProgress();
    //   if (isLoggedIn) {
    //     Dialogs.showProgress(message: "Đang lấy thông tin tài khoản...");
    //     await AuthRepository().checkSession();
    //     Dialogs.hideProgress();
    //   } else {
    //     Dialogs.alert(
    //         message:
    //             "Đăng nhập thất bại!\nVui lòng kiểm tra thông tin tài khoản hoặc mật khẩu.");
    //   }
    // }
  }

  Future<void> loginAsAnonymousWithSavedAccount() async {
    if (AppController.hasConnection) {
      Dialogs.showProgress(message: "Đang đăng nhập...");
      // var isLoggedIn = await AuthRepository()
      //     .loginAsAnonymous(AppSettingController.localSetting.value?.userName ?? "",
      //         AppSettingController.localSetting.value?.password ?? "")
      //     .catchError((error) {});
      // Dialogs.hideProgress();
      // if (isLoggedIn) {
      //   Dialogs.showProgress(message: "Đang lấy thông tin tài khoản...");
      //   await AuthRepository().checkSession();
      //   Dialogs.hideProgress();
      // } else {
      //   Dialogs.alert(
      //       message:
      //           "Đăng nhập thất bại!\nVui lòng kiểm tra thông tin tài khoản hoặc mật khẩu.");
      // }
    }
  }
}
