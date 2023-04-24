import 'package:flutter/material.dart';
import 'package:love_novel/ui/components/app_menu.dart';
import 'package:love_novel/ui/components/app_theme.dart';
import 'package:upgrader/upgrader.dart';

class AppScaffold extends StatefulWidget {
  Widget body;
  Widget? appMenu;
  Widget? bottomNavigationBar;
  String title;
  List<Widget> actions;
  AppScaffold(
      {Key? key,
      required this.body,
      this.title = "",
      this.actions = const [],
      this.appMenu,
      this.bottomNavigationBar})
      : super(key: key);

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  final _globalKey = GlobalKey<ScaffoldState>();

  var isDark = false;

  void setAppState(VoidCallback fn) {
    if (mounted) setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    // Upgrader.clearSavedSettings();
    return Scaffold(
      key: _globalKey,
      // backgroundColor: AppTheme.textColor,
      body: UpgradeAlert(
        child: Column(children: [
          Expanded(
            child: widget.body,
          ),
          if (widget.appMenu != null) widget.appMenu!
        ]),
      ),
      bottomNavigationBar: widget.bottomNavigationBar,
    );
  }
}
