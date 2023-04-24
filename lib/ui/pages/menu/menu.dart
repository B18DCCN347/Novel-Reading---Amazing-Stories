import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:love_novel/app/global/controller.dart';
import 'package:love_novel/app/utils/dialogs.dart';
import 'package:love_novel/ui/components/app_menu_bar.dart';
import 'package:love_novel/ui/components/app_theme.dart';
import 'package:love_novel/ui/components/texts.dart';
import 'package:love_novel/ui/pages/book/controller.dart';
import 'package:love_novel/ui/pages/menu/controller.dart';
import 'package:love_novel/ui/pages/webview/webview.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuView extends StatelessWidget {
  MenuView({Key? key}) : super(key: key);
  var controller = MenuController.instance;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        AppMenuBar(title: "Menu"),
        Expanded(
          child: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Icon(
                  Icons.account_circle,
                  color: AppTheme.greyColor,
                  size: 148,
                ),
              ),
              Obx(() {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DisabledText("ID: ${MenuController.customerId.value}"),
                );
              }),
              // AppButton(
              //   text: "Sign In / Sign Up",
              //   color: Color.fromARGB(255, 20, 123, 207),
              //   onPressed: () {
              //     AppController.toNamed(LoginPage.route);
              //   },
              // ),
              SizedBox(
                height: 16,
              ),
              // MenuItem(
              //   title: "Community",
              //   iconData: FontAwesomeIcons.globe,
              // ),
              MenuItem(
                title: "Review & Rating App",
                iconData: FontAwesomeIcons.star,
                onTap: () async {
                  var url =
                      'https://play.google.com/store/apps/details?id=com.napoam21.novelreadingfree.amazingstories';
                  if (!await launch(
                    url,
                    forceSafariVC: false,
                    forceWebView: false,
                    // headers: <String, String>{
                    //   'my_header_key': 'my_header_value'
                    // },
                  )) {
                    Dialogs.alert(
                        message:
                            'Hiện tại không thể truy cập trang!\nVui lòng thử lại sau');
                  }
                },
              ),
              MenuItem(
                title: "Share to Friends",
                iconData: FontAwesomeIcons.share,
                onTap: () {
                  BookController.instance.share();
                },
              ),
              // MenuItem(
              //   title: "Suggest story",
              //   iconData: FontAwesomeIcons.sms,
              // ),
              MenuItem(
                title: "Bug Report",
                iconData: FontAwesomeIcons.bug,
                onTap: () {
                  AppController.toNamed(WebViewPage.route);
                },
              ),
              // MenuItem(
              //   title: "Terms & Conditions",
              //   iconData: FontAwesomeIcons.book,
              // ),
              MenuItem(
                title: "Policy",
                iconData: FontAwesomeIcons.shield,
                onTap: () async {
                  var url = 'http://nganha.info/policy';
                  if (!await launch(
                    url,
                    forceSafariVC: false,
                    forceWebView: false,
                    // headers: <String, String>{
                    //   'my_header_key': 'my_header_value'
                    // },
                  )) {
                    Dialogs.alert(
                        message:
                            'Hiện tại không thể truy cập trang!\nVui lòng thử lại sau');
                  }
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom + 32,
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData iconData;
  final String title;
  final VoidCallback? onTap;
  const MenuItem(
      {Key? key, required this.title, required this.iconData, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) onTap!();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 28),
        decoration: BoxDecoration(
            border:
                Border(top: BorderSide(color: AppTheme.disabledColorLight))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Icon(
                iconData,
                size: 32,
                color: AppTheme.greyColor,
              ),
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Icon(
                Icons.chevron_right,
                size: 32,
                color: AppTheme.greyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
