import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:love_novel/app/global/controller.dart';
import 'package:love_novel/app/utils/dialogs.dart';
import 'package:love_novel/app/utils/string_helper.dart';

class RegisterController extends GetxController {
  static RegisterController get instance =>
      Get.isRegistered<RegisterController>()
          ? Get.find()
          : Get.put(RegisterController());
  final _appController = AppController.instance;

  String email = "",
      userName = "",
      inviter = "",
      password = "",
      repassword = "";

  Future<void> register() async {
    if (AppController.hasConnection) {
      email = email.trim();
      userName = userName.trim();
      password = password.trim();
      repassword = repassword.trim();
      if (!StringHelper.isValidEmail(email)) {
        Dialogs.alert(message: "Vui lòng nhập đúng định dạng email!");
      } else if (!RegExp(r'^(?=[a-zA-Z0-9._]{6,20}$)(?!.*[_.]{2})[^_.].*[^_.]$')
          .hasMatch(userName)) {
        Dialogs.alert(
            message:
                "Tên đăng ký phải có ít nhất 6 kí tự,\ncó chữ và số,\nkhông được bắt đầu và kết thúc bằng kí tự đặc biệt!");
      } else if (password.isNotEmpty &&
          userName.isNotEmpty &&
          password == repassword) {
        // Dialogs.showProgress(message: "Đang đăng ký...");
        // var response = await UserRepository()
        //     .register(RegisterModel(
        //         userName: userName, password: password, email: email, inviter: inviter))
        //     .catchError((error) {
        //       print(error.toString());
        //     });
        // Dialogs.hideProgress();
        // if (response?.success ?? false) {
        //   await Dialogs.alert(message:response?.message?? "Đăng ký thành công!");
        //   await Get.offNamedUntil(LoginPage.route, (route) => false);
        // } else {
        //   Dialogs.alert(
        //       message: response?.message ??
        //           "Đăng kí thất bại!\nVui lòng kiểm tra thông tin tài khoản hoặc mật khẩu.");
        // }
      } else
        Dialogs.alert(message: "Mật khẩu không trùng khớp.");
    }
  }
}
