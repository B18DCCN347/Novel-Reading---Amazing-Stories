import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_novel/app/global/controller.dart';
import 'package:love_novel/ui/components/app_theme.dart';
import 'package:love_novel/ui/components/rounded_button.dart';
import 'package:love_novel/ui/components/rounded_text_field.dart';
import 'package:love_novel/ui/components/rounded_password_field.dart';
import 'package:love_novel/ui/pages/account/login/login_controller.dart';
import 'package:love_novel/ui/pages/account/register/register.dart';

class LoginPage extends StatelessWidget {
  static const route = '/login';
  final controller = LoginController.instance;
  // static final FacebookLogin facebookLogin = new FacebookLogin();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Stack(
              children: [
                Container(
                  width: size.width,
                  height: size.height,
                  color: AppTheme.primaryColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Text(
                        "Sign In",
                        style: TextStyle(
                            color: AppTheme.brightColor,
                            fontSize: 32,
                            height: 2),
                      ),
                      Text(
                        "Welcome to Novel World",
                        style: TextStyle(
                            color: AppTheme.brightColor,
                            fontSize: 18,
                            height: 2),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: MediaQuery.of(context).padding.top + 20,
                    left: 16,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: AppTheme.brightColor.withOpacity(0.8),
                      ),
                      iconSize: 32,
                      onPressed: () {
                        Get.back();
                      },
                    ))
              ],
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: size.width,
                height: size.height * .8,
                decoration: BoxDecoration(
                    color: AppTheme.brightColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(48),
                      topRight: Radius.circular(48),
                    )),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 48,
                      ),
                      RoundedTextField(
                        hintText: "Email",
                        value: controller.userName,
                        onChanged: (value) {
                          controller.userName = value;
                        },
                      ),
                      RoundedPasswordField(
                        hintText: "Password",
                        value: controller.password,
                        onChanged: (value) {
                          controller.password = value ?? "";
                        },
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      RoundedButton(
                        color: AppTheme.successColor,
                        text: "Sign In",
                        onPressed: controller.loginAsAnonymous,
                      ),
                      Text(
                        "Or",
                        style: TextStyle(height: 3, color: AppTheme.greyColor),
                      ),
                      RoundedButton(
                        color: AppTheme.blueColor,
                        text: "Facebook",
                        onPressed: () async {
                          // final FacebookLoginResult result = await facebookLogin
                          //     .logIn(customPermissions: ['email']);
                          // if (result.status == FacebookLoginStatus.success) {
                          // } else {
                          //   await showDialog<Object>(
                          //     context: context,
                          //     builder: (context) => const AlertDialog(
                          //       content: Text(
                          //           "Can't make express log in. Try regular log in."),
                          //     ),
                          //   );
                          // }
                          // var a = 1;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't Have an Account?",
                            style:
                                TextStyle(height: 2, color: AppTheme.greyColor),
                          ),
                          InkWell(
                            onTap: () {
                              AppController.toNamed(RegisterPage.route);
                            },
                            child: Text(
                              "  Sign Up",
                              style: TextStyle(
                                  height: 2, color: AppTheme.primaryColor),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.03),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
